import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class CreateNewClient extends StatelessWidget {
  const CreateNewClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: WrapProfile(
          child: Column(
        children: [
          const NavBar(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(children: [
              const SideBar(
                selectedRoute: SelectedRoute.createClient,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Text(
                            "Create > Clients > ",
                            style: ClanChurnTypography.font16500,
                          ),
                          Text(
                            "Create New Client",
                            style: ClanChurnTypography.font16500.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: ChurnContainer(child: Expanded(child: Text("")))),
                  ],
                ),
              )
            ]),
          )
        ],
      )),
    );
  }
}
