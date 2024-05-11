import 'dart:developer';

import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/componnents/clients_component.dart';
import 'package:clan_churn/componnents/profile.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: const ClanChurnAppBar(),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: Column(children: [
        // profile and logo bar
        Container(
          height: h * 0.1,
          color: Theme.of(context).colorScheme.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 20,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/clan_logo.png",
                      scale: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: VerticalDivider(
                        color: Color.fromRGBO(175, 175, 175, 1),
                        thickness: 1,
                      ),
                    ),
                    Image.asset(
                      "assets/churn_logo.png",
                      scale: 2,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  ClanChurnSpacing.w10,
                  const ProfileWidget(),
                  ClanChurnSpacing.w10,
                ],
              )
            ],
          ),
        ),
        SizedBox(height: h * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: h * 0.89,
              width: isExpanded ? w * 0.05 : w * 0.15,
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
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.keyboard_double_arrow_left),
                                ClanChurnSpacing.w10,
                                isExpanded
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.home),
                              ClanChurnSpacing.w10,
                              isExpanded
                                  ? Container()
                                  : AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      child: Text(
                                        "Home",
                                        style: ClanChurnTypography.font16700,
                                      ),
                                    )
                            ],
                          ),
                        ),
                        // saved reports
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.save),
                              ClanChurnSpacing.w10,
                              isExpanded
                                  ? Container()
                                  : AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      child: Text(
                                        "Saved Reports",
                                        style: ClanChurnTypography.font16700,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // logout
                    InkWell(
                      onTap: () {
                        context
                            .read<SignInBloc>()
                            .add(SignOutEvent(context: context));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.logout_outlined,
                                color: Colors.red),
                            ClanChurnSpacing.w10,
                            isExpanded
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
                  ]),
            ),
            ClientsComponent(
              width: isExpanded ? w * 0.9 : w * 0.8,
            )
            // const ClientsViewComponent()
          ],
        )
      ]),
    );
  }
}
