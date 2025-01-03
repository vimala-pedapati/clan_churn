import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/admin/admin_client_card.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/utils/typography.dart';
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

  @override
  void initState() {
    setState(() {
      clientsFetching = true;
    });
    context.read<UserBloc>().add(GetUserDetailsEvent(context: context));
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
          },
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChurnContainer(
        child: clientsFetching
            ? Center(child: Image.asset("assets/upload.gif", width: 100))
            : clientsFetchingError
                ? const Center(
                    child: Text("Unable to fetch data clients data"),
                  )
                : SingleChildScrollView(
                    child: BlocBuilder<ProjectArchitectBloc,
                        ProjectArchitectState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active Clients",
                              style: ClanChurnTypography.font20600,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: state.clientList.map((c) {
                                return AdminClientCard(
                                  client: c,
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ));
  }
}
