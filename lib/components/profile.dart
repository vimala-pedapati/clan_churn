import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, this.onTap});
  final Function()? onTap;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.user == null
            ? Container()
            : Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  ClanChurnSpacing.w10,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isExpanded ? h * 0.13 : h * 0.07,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: const Icon(
                                Icons.expand_circle_down_outlined,
                              )),
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
                        isExpanded
                            ? InkWell(
                                onTap: () {
                                  context
                                      .read<SignInBloc>()
                                      .add(SignOutEvent(context: context));
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.logout_outlined,
                                          color: Colors.red),
                                      ClanChurnSpacing.w10,
                                      state.isExpanded
                                          ? Container()
                                          : AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 1),
                                              child: Text(
                                                "Log Out",
                                                style: ClanChurnTypography
                                                    .font18600
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  ClanChurnSpacing.w10,
                ],
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
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined, color: Colors.red),
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
