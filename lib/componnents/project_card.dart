import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
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
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: const Icon(Icons.person),
                ),
                Column(
                  children: [
                    Text(
                      "Company Name",
                      style: ClanChurnTypography.font15600,
                    ),
                    Text(
                      "Project Name",
                      style: ClanChurnTypography.font12500,
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
                    onPressed: () {},
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
        //               // context.read<UserBloc>().add(SetSelectedClientEvent(selectedClient: state.clientList[index]));
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
