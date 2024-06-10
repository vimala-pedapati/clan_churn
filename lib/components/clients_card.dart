import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/pages/client_projects_view.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsCard extends StatelessWidget {
  const ClientsCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          height: 190,
          width: 160,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: state.isNotExpanded? 35: 40,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                    size: state.isNotExpanded? 35: 40,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      state.clientList[index].name,
                      style: ClanChurnTypography.font15600,
                    ),
                    // Text(
                    //   "${state.clientList[index].role}",
                    //   style: ClanChurnTypography.font12500,
                    // ),
                  ],
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        shape: const StadiumBorder()),
                    child: Text(
                      "View",
                      style: ClanChurnTypography.font15600,
                    ),
                    onPressed: () {
                      context.read<ProjectArchitectBloc>().add(
                          SetSelectedClientEvent(
                              selectedClient: state.clientList[index]));
                      // GoRouter.of(context).go(AppRoutes.clientProjects);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ClientProjectsView()));
                    },
                  ),
                )
              ]),
        );
      },
    );
  }
}
