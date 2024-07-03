// import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
// import 'package:clan_churn/utils/routes.dart';
// import 'package:clan_churn/utils/spacing.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// enum SelectedRoute { home, savedReports }

// class SideBar extends StatefulWidget {
//   final SelectedRoute selectedRoute;
//   const SideBar({super.key, required this.selectedRoute});

//   @override
//   State<SideBar> createState() => _SideBarState();
// }

// class _SideBarState extends State<SideBar> {
//   double rotationAngle = 0;
//   bool isNotExpanded = false;
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     // final w = MediaQuery.of(context).size.width;
//     return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
//       builder: (context, state) {
//         return AnimatedContainer(
//           duration: const Duration(seconds: 1),
//           // height: h * 0.89,
//           // width: state.isNotExpanded ? w * 0.05 : w * 0.15,
//           height: h * 0.88,
//           width: state.isNotExpanded ? 90 : 220,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.background,
//           ),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     // menu
//                     InkWell(
//                       onTap: () {
//                         context.read<ProjectArchitectBloc>().add(
//                             SideBarExpandedEvent(
//                                 isNotExpanded: !state.isNotExpanded));
//                         setState(() {
//                           isNotExpanded = !isNotExpanded;
//                           if (isNotExpanded) {
//                             rotationAngle += 180;
//                           } else {
//                             rotationAngle -= 180;
//                           }
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 10, top: 10, bottom: 10, right: 10),
//                         padding: const EdgeInsets.only(
//                             left: 20, top: 10, bottom: 10),
//                         child: Row(
//                           children: [
//                             AnimatedRotation(
//                                 turns: rotationAngle / 360,
//                                 duration: const Duration(milliseconds: 300),
//                                 child: Icon(
//                                   Icons.keyboard_double_arrow_left,
//                                   color:
//                                       Theme.of(context).colorScheme.secondary,
//                                 )),
//                             ClanChurnSpacing.w10,
//                             state.isNotExpanded
//                                 ? Container()
//                                 : AnimatedContainer(
//                                     duration: const Duration(seconds: 1),
//                                     child: Text(
//                                       "Menu",
//                                       style: ClanChurnTypography.font16700,
//                                     ),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                     // home
//                     InkWell(
//                       onTap: () {
//                         GoRouter.of(context).go(AppRoutes.home);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.only(
//                             left: 20, top: 10, bottom: 10),
//                         margin: const EdgeInsets.only(
//                             left: 10, top: 10, bottom: 10, right: 10),
//                         decoration: widget.selectedRoute == SelectedRoute.home
//                             ? BoxDecoration(
//                                 color: Theme.of(context)
//                                     .colorScheme
//                                     .primary
//                                     .withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(5))
//                             : null,
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.home,
//                               color: widget.selectedRoute == SelectedRoute.home
//                                   ? null
//                                   : Theme.of(context).colorScheme.secondary,
//                             ),
//                             ClanChurnSpacing.w10,
//                             state.isNotExpanded
//                                 ? Container()
//                                 : AnimatedContainer(
//                                     duration: const Duration(seconds: 1),
//                                     child: Text(
//                                       "Home",
//                                       style: ClanChurnTypography.font16700
//                                           .copyWith(
//                                               color: widget.selectedRoute ==
//                                                       SelectedRoute.home
//                                                   ? Theme.of(context)
//                                                       .colorScheme
//                                                       .primary
//                                                   : null),
//                                     ),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                     // saved reports
//                     InkWell(
//                       onTap: widget.selectedRoute == SelectedRoute.savedReports
//                           ? null
//                           : () {
//                               GoRouter.of(context).go(AppRoutes.savedProjects);
//                             },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 10, top: 10, bottom: 10, right: 10),
//                         decoration:
//                             widget.selectedRoute == SelectedRoute.savedReports
//                                 ? BoxDecoration(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .primary
//                                         .withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(5))
//                                 : null,
//                         padding: const EdgeInsets.only(
//                             left: 20, top: 10, bottom: 10),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.save,
//                               color: widget.selectedRoute ==
//                                       SelectedRoute.savedReports
//                                   ? null
//                                   : Theme.of(context).colorScheme.secondary,
//                             ),
//                             ClanChurnSpacing.w10,
//                             state.isNotExpanded
//                                 ? Container()
//                                 : AnimatedContainer(
//                                     duration: const Duration(seconds: 1),
//                                     child: Text(
//                                       "Saved Reports",
//                                       style: ClanChurnTypography.font16700
//                                           .copyWith(
//                                               color: widget.selectedRoute ==
//                                                       SelectedRoute.savedReports
//                                                   ? Theme.of(context)
//                                                       .colorScheme
//                                                       .primary
//                                                   : null),
//                                     ),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 state.isNotExpanded
//                     ? Container()
//                     : Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Text(
//                           "powered by TMI Group",
//                           style: ClanChurnTypography.font14400,
//                         ),
//                     ),
//                 // logout
//                 // InkWell(
//                 //   onTap: () {
//                 //     context
//                 //         .read<SignInBloc>()
//                 //         .add(SignOutEvent(context: context));
//                 //   },
//                 //   focusNode: null,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(
//                 //         left: 10, top: 10, bottom: 10, right: 10),
//                 //     padding:
//                 //         const EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 //     child: Row(
//                 //       children: [
//                 //         const Icon(Icons.logout_outlined, color: Colors.red),
//                 //         ClanChurnSpacing.w10,
//                 //         state.isNotExpanded
//                 //             ? Container()
//                 //             : AnimatedContainer(
//                 //                 duration: const Duration(seconds: 1),
//                 //                 child: Text(
//                 //                   "Log Out",
//                 //                   style: ClanChurnTypography.font16700
//                 //                       .copyWith(color: Colors.red),
//                 //                 ),
//                 //               )
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ]),
//         );
//       },
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('EndDrawer Example'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               Scaffold.of(context).openEndDrawer();
//             },
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text(
//             'Swipe from the right or click the menu icon to open the EndDrawer.'),
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'End Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.message),
//               title: const Text('Messages'),
//               onTap: () {
//                 // Handle tap
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_circle),
//               title: const Text('Profile'),
//               onTap: () {
//                 // Handle tap
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 // Handle tap
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Enum to manage selected routes
enum SelectedRoute { home, savedReports }

class SideBar extends StatefulWidget {
  final SelectedRoute selectedRoute;
  const SideBar({super.key, required this.selectedRoute});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  double rotationAngle = 0;
  bool isNotExpanded = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: state.isNotExpanded ? 90 : 220,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Menu button
                  buildMenuButton(context, state),
                  projectArchitectControls()
          
                  // BlocBuilder<UserBloc, UserState>(
                  //   builder: (context, state) {
                  //     return state.user?.userType == UserType.projectArchitect
                  //         ? projectArchitectControls()
                  //         : state.user?.userType == UserType.admin
                  //             ? adminControls()
                  //             : Container();
                  //   },
                  // )
                ],
              ),
              // Footer text
              state.isNotExpanded ? Container() : buildFooterText(),
            ],
          ),
        );
      },
    );
  }

  Widget adminControls() {
    return Column();
  }

  Widget projectArchitectControls() {
    return Column(
      children: [
        // Home button
        buildHomeButton(context),
        // Saved Reports button
        buildSavedReportsButton(context),
      ],
    );
  }

  Widget buildMenuButton(BuildContext context, ProjectArchitectState state) {
    return InkWell(
      onTap: () {
        context
            .read<ProjectArchitectBloc>()
            .add(SideBarExpandedEvent(isNotExpanded: !state.isNotExpanded));
        setState(() {
          isNotExpanded = !isNotExpanded;
          rotationAngle += isNotExpanded ? 180 : -180;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Row(
          children: [
            AnimatedRotation(
              turns: rotationAngle / 360,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.keyboard_double_arrow_left,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ClanChurnSpacing.w10,
            state.isNotExpanded
                ? Container()
                : AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: Text(
                      "Menu",
                      style: ClanChurnTypography.font16700,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildHomeButton(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).go(AppRoutes.home);
      },
      child: buildButtonContainer(
        icon: Icons.home,
        text: "Home",
        isSelected: widget.selectedRoute == SelectedRoute.home,
      ),
    );
  }

  Widget buildSavedReportsButton(BuildContext context) {
    return InkWell(
      onTap: widget.selectedRoute == SelectedRoute.savedReports
          ? null
          : () {
              GoRouter.of(context).go(AppRoutes.savedProjects);
            },
      child: buildButtonContainer(
        icon: Icons.save,
        text: "Saved Reports",
        isSelected: widget.selectedRoute == SelectedRoute.savedReports,
      ),
    );
  }

  Widget buildButtonContainer(
      {required IconData icon,
      required String text,
      required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      margin: const EdgeInsets.all(10),
      decoration: isSelected
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            )
          : null,
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? null : Theme.of(context).colorScheme.secondary,
          ),
          ClanChurnSpacing.w10,
          isNotExpanded
              ? Container()
              : AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  child: Text(
                    text,
                    style: ClanChurnTypography.font16700.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildFooterText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "powered by TMI Group",
        style: ClanChurnTypography.font14400,
      ),
    );
  }
}
