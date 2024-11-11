import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/admin/create_client_body.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({super.key});

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  bool clientsFetching = false;
  bool clientsFetchingError = false;
  @override
  void initState() {
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: WrapProfile(
        child: Column(children: [
          const NavBar(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Row(
            children: [
              const SideBar(
                selectedRoute: SelectedRoute.createClient,
              ),
              clientsFetching
                  ? Center(child: Image.asset("assets/upload.gif", width: 100))
                  : clientsFetchingError
                      ? const Center(
                          child: Text("Unable to fetch data clients data"),
                        )
                      : const Expanded(child: ChurnContainer(child: CreateClientBody()))
            ],
          ))
        ]),
      ),
    );
  }
}
