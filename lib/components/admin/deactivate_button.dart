
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/pages/admin_home_page.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeactivateButton extends StatelessWidget {
  const DeactivateButton(
      {super.key, required this.clientId, required this.onNextPage});
  final String clientId;
  final Function() onNextPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.projectsList.isEmpty
              ? () {
                  context.read<ClientBloc>().add(DeleteClientEvent(
                        clientId: clientId,
                        onErrorCallback: (errorMessage, errorCode) {
                          print(
                              "Delete Client error call back : $errorMessage $errorCode");
                        },
                        onSuccessCallback: (message) {
                          Navigator.pushReplacement(
                              context,
                              customPageRouteForNavigation(
                                  const AdminHomePage()));
                        },
                      ));
                }
              : onNextPage,
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error),
          child: Row(
            children: [
              const Icon(Icons.archive_outlined),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                child: Text(
                  "Deactivate Client",
                  style: ClanChurnTypography.font15600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

