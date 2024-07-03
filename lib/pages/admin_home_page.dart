import 'package:clan_churn/components/admin/admin_clients_component.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: const WrapProfile(
          child: Column(
        children: [
          NavBar(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                SideBar(
                  selectedRoute: SelectedRoute.home,
                ),
                Expanded(child: AdminClientsComponet())
              ],
            ),
          )
        ],
      )),
    );
  }
}
