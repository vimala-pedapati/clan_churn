import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.user == null
            ? Container()
            : InkWell(
                onTap: onTap ??
                    () {
                      Scaffold.of(context).openEndDrawer();
                    },
                child: Row(
                  children: [
                    Container(
                      height: h * 0.07,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                        const Icon(
                          Icons.expand_circle_down_outlined,
                        ),
                        ClanChurnSpacing.w5,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                return Text(
                                  "${state.user!.firstName} ${state.user!.lastName}",
                                  style: ClanChurnTypography.font15600,
                                );
                              },
                            ),
                            Text(
                              "${state.user!.userType} - ${state.user!.clientDetails.name}",
                              style: ClanChurnTypography.font10600,
                            )
                          ],
                        ),
                        ClanChurnSpacing.w5,
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          child: const Icon(
                            Icons.person,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Drawer(
              child: Column(
                children: [
                  ProfileWidget(
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<SignInBloc>()
                          .add(SignOutEvent(context: context));
                    },
                    focusNode: null,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.logout_outlined,
                              color: Colors.red),
                          ClanChurnSpacing.w10,
                          state.isExpanded
                              ? Container()
                              : AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  child: Text(
                                    "Log Out",
                                    style: ClanChurnTypography.font16700
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
