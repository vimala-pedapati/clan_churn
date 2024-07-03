import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/admin/admin_client_card.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminClientsComponet extends StatefulWidget {
  const AdminClientsComponet({super.key});

  @override
  State<AdminClientsComponet> createState() => _AdminClientsComponetState();
}

class _AdminClientsComponetState extends State<AdminClientsComponet> {
  bool clientsFetching = false;
  bool clientsFetchingError = false;
  List<ClientDetails> a = [];

  @override
  void initState() {
    setState(() {
      clientsFetching = true;
    });
    context.read<ProjectArchitectBloc>().add(GetClientsEvent(
          onErrorCallback: ((errorMessage, errorCode) {
            setState(() {
              clientsFetching = false;
              clientsFetchingError = true;
            });
          }),
          onSuccessCallback: (message) {
            setState(() {
              clientsFetching = false;
            });

            setState(() {
              for (int i = 0; i < 100; i++) {
                a.add(context.read<ProjectArchitectBloc>().state.clientList[0]);
              }
            });
          },
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChurnContainer(
        child: clientsFetching
            ? Center(child: Image.asset("assets/loading.gif", width: 30))
            : clientsFetchingError
                ? const Center(
                    child: Text("Unable to fetch data clients data"),
                  )
                : SingleChildScrollView(
                  child: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                      builder: (context, state) {
                        return Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: a.map((c) {
                            return AdminClientCard(
                              client: c,
                            );
                          }).toList(),
                        );
                      },
                    ),
                ));
  }
}
