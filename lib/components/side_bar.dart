import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart'; 
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum SelectedRoute { home, savedReports }

class SideBar extends StatefulWidget {
  final SelectedRoute selectedRoute;
  const SideBar({super.key, required this.selectedRoute});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: h * 0.89,
          width: state.isExpanded ? w * 0.06 : w * 0.15,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    // menu
                    InkWell(
                      onTap: () {
                        context.read<ProjectArchitectBloc>().add(SideBarExpandedEvent(
                            isExpanded: !state.isExpanded));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.keyboard_double_arrow_left),
                            ClanChurnSpacing.w10,
                            state.isExpanded
                                ? Container()
                                : AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    child: Text(
                                      "Menu",
                                      style: ClanChurnTypography.font16700,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    // home
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).go(AppRoutes.home);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        decoration: widget.selectedRoute == SelectedRoute.home
                            ? BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5))
                            : null,
                        child: Row(
                          children: [
                            const Icon(Icons.home),
                            ClanChurnSpacing.w10,
                            state.isExpanded
                                ? Container()
                                : AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    child: Text(
                                      "Home",
                                      style: ClanChurnTypography.font16700
                                          .copyWith(
                                              color: widget.selectedRoute ==
                                                      SelectedRoute.home
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : null),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    // saved reports
                    InkWell(
                      onTap: widget.selectedRoute == SelectedRoute.savedReports
                          ? null
                          : () {
                              GoRouter.of(context).go(AppRoutes.savedProjects);
                            },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        decoration:
                            widget.selectedRoute == SelectedRoute.savedReports
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5))
                                : null,
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.save),
                            ClanChurnSpacing.w10,
                            state.isExpanded
                                ? Container()
                                : AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    child: Text(
                                      "Saved Reports",
                                      style: ClanChurnTypography.font16700
                                          .copyWith(
                                              color: widget.selectedRoute ==
                                                      SelectedRoute.savedReports
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : null),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // logout
                // InkWell(
                //   onTap: () {
                //     context
                //         .read<SignInBloc>()
                //         .add(SignOutEvent(context: context));
                //   },
                //   focusNode: null,
                //   child: Container(
                //     margin: const EdgeInsets.only(
                //         left: 10, top: 10, bottom: 10, right: 10),
                //     padding:
                //         const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                //     child: Row(
                //       children: [
                //         const Icon(Icons.logout_outlined, color: Colors.red),
                //         ClanChurnSpacing.w10,
                //         state.isExpanded
                //             ? Container()
                //             : AnimatedContainer(
                //                 duration: const Duration(seconds: 1),
                //                 child: Text(
                //                   "Log Out",
                //                   style: ClanChurnTypography.font16700
                //                       .copyWith(color: Colors.red),
                //                 ),
                //               )
                //       ],
                //     ),
                //   ),
                // ),
              ]),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EndDrawer Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
            'Swipe from the right or click the menu icon to open the EndDrawer.'),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'End Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
