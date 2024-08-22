import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/project_card.dart';
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

class _ProfileWidgetState extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  bool isNotExpanded = false;

  double rotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
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
                    height: isNotExpanded ? 120 : 60,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(1),
                        borderRadius:
                            BorderRadius.circular(isNotExpanded ? 30 : 30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.none,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isNotExpanded = !isNotExpanded;
                                    if (isNotExpanded) {
                                      rotationAngle += 180;
                                    } else {
                                      rotationAngle -= 180;
                                    }
                                  });
                                },
                                icon: AnimatedRotation(
                                  turns: rotationAngle / 360,
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    Icons.expand_circle_down_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                )),
                          ),
                          ClanChurnSpacing.w5,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<UserBloc, UserState>(
                                builder: (context, state) {
                                  return Text(
                                    "${state.user?.firstName} ${state.user?.lastName}",
                                    style: ClanChurnTypography.font15600
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                  );
                                },
                              ),
                              Text(
                                "${state.user?.userType.value}",
                                style: ClanChurnTypography.font10600.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              )
                            ],
                          ),
                          ClanChurnSpacing.w5,
                          CircleAvatar(
                            radius: 18,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            child: ClipOval(
                              child: Image.network(
                                "${state.user!.image}",
                                // loadingBuilder:
                                //     ((context, child, loadingProgress) {
                                //   return const CircularProgressIndicator();
                                // }),
                                errorBuilder: (context, error, stackTrace) {
                                  return ClipOval(
                                      child: Image.network(
                                    image,
                                    scale: 2,
                                  ));
                                },
                              ),
                            ),
                          ),
                        ]),
                        isNotExpanded
                            ? InkWell(
                                onTap: () {
                                  context
                                      .read<SignInBloc>()
                                      .add(SignOutEvent(context: context));
                                },
                                child: BlocBuilder<ProjectArchitectBloc,
                                    ProjectArchitectState>(
                                  builder: (context, state) {
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 20),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.logout_outlined,
                                              color: Colors.red),
                                          ClanChurnSpacing.w10,
                                          AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 1),
                                            child: Text(
                                              "Log Out",
                                              style: ClanChurnTypography
                                                  .font18600
                                                  .copyWith(color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
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
                  child:
                      BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          const Icon(Icons.logout_outlined, color: Colors.red),
                          ClanChurnSpacing.w10,
                          state.isNotExpanded
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
                      );
                    },
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
