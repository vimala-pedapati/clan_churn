import 'package:clan_churn/componnents/clients_component.dart';
import 'package:clan_churn/componnents/profile.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: const ClanChurnAppBar(),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: Column(children: [
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: h * 0.89,
              width: w * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(children: [
                ClanChurnSpacing.h10,
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.keyboard_double_arrow_left),
                      ClanChurnSpacing.w10,
                      Text(
                        "Menu",
                        style: ClanChurnTypography.font16700,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.home),
                      ClanChurnSpacing.w10,
                      Text(
                        "Home",
                        style: ClanChurnTypography.font16700,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.save),
                      ClanChurnSpacing.w10,
                      Text(
                        "Saved Reports",
                        style: ClanChurnTypography.font16700,
                      )
                    ],
                  ),
                ),
              ]),
            ),
            const ClientsComponent()
            // const ClientsViewComponent()
          ],
        )
      ]),
    );
  }
}
