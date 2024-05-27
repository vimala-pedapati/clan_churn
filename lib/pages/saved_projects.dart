import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:flutter/material.dart';

class SavedProjects extends StatelessWidget {
  const SavedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: Column(children: [
        const NavBar(),
        SizedBox(height: h * 0.01),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideBar(
              selectedRoute: SelectedRoute.savedReports,
            )
          ],
        )
      ]),
    );
  }
}
