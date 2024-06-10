import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:clan_churn/pages/project_input_fields_sheet.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCard extends StatelessWidget {
  final int index;
  const ProjectCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          // height: 190,
          // width: 160,
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
                  radius: state.isNotExpanded ? 35 : 40,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                    size: state.isNotExpanded ? 35 : 40,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      state.selectedClient!.name,
                      style: ClanChurnTypography.font12500,
                    ),
                    Text(
                      "${state.projectsList[index].name}",
                      style: ClanChurnTypography.font15600,
                    ),
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
                          SetCreatedProjectEvent(
                              createdProject: state.projectsList[index]));
                      if (state.projectsList[index].inputSheet == null) {
                        Navigator.push(
                            context,
                            customPageRouteForNavigation(
                                const CreateNewProject()));
                      } else {
                        Navigator.push(
                            context,
                            customPageRouteForNavigation(
                                const ProjectInputFieldsPage()));
                      }
                    },
                  ),
                )
              ]),
        );

        // Container(
        //   // height: 190,
        //   // width: 160,
        //   padding:
        //       const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        //   decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        //       border: Border.all(color: Theme.of(context).colorScheme.primary),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "${state.user!.firstName} ${state.user!.lastName}",
        //                     style: ClanChurnTypography.font15600.copyWith(
        //                         color: Theme.of(context).colorScheme.background),
        //                   ),
        //                   Text(
        //                     "${state.user!.userType} - ${state.user!.clientDetails.name}",
        //                     style: ClanChurnTypography.font12600.copyWith(
        //                         color: Theme.of(context).colorScheme.background),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             CircleAvatar(
        //               radius: 20,
        //               backgroundColor: Theme.of(context).colorScheme.background,
        //               child: const Icon(Icons.person),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: [
        //             Text(
        //               "Piramal_Emp_Data_Oct",
        //               style: ClanChurnTypography.font15600.copyWith(
        //                   color: Theme.of(context).colorScheme.background),
        //             ),
        //             // Row(
        //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             //   children: [
        //             //     Text(
        //             //       "#S123",
        //             //       style: ClanChurnTypography.font12600.copyWith(
        //             //           color: Theme.of(context)
        //             //               .colorScheme
        //             //               .primary
        //             //               .withOpacity(1)),
        //             //     ),
        //             //     Text(
        //             //       "25/12/2024",
        //             //       style: ClanChurnTypography.font12600.copyWith(
        //             //           color: Theme.of(context)
        //             //               .colorScheme
        //             //               .primary
        //             //               .withOpacity(1)),
        //             //     ),
        //             //     Text(
        //             //       "complete",
        //             //       style: ClanChurnTypography.font12600.copyWith(
        //             //           color: Theme.of(context)
        //             //               .colorScheme
        //             //               .primary
        //             //               .withOpacity(1)),
        //             //     )
        //             //   ],
        //             // ),
        //           ],
        //         ),
        //         SizedBox(
        //           width: double.infinity,
        //           child: OutlinedButton(
        //             style: OutlinedButton.styleFrom(
        //               padding: const EdgeInsets.only(left: 20, right: 20),
        //               backgroundColor: Theme.of(context).colorScheme.background,
        //               side: BorderSide(
        //                   color: Theme.of(context).colorScheme.primary),
        //             ),
        //             child: Text(
        //               "View",
        //               style: ClanChurnTypography.font15600,
        //             ),
        //             onPressed: () {
        //               // context.read<ProjectArchitectBloc>().add(SetSelectedClientEvent(selectedClient: state.clientList[index]));
        //               // GoRouter.of(context).go(AppRoutes.clientProjects);
        //             },
        //           ),
        //         )
        //       ]),
        // );
      },
    );
  }
}
