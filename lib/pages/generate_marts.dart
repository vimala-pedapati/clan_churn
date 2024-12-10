import 'package:clan_churn/components/wrap_profile.dart';
import 'package:flutter/material.dart';

import '../components/nav_bar.dart';

class GenerateMarts extends StatelessWidget {
  const GenerateMarts({super.key, required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      body: const WrapProfile(
          child: Column(
        children: [
          NavBar(),
          SizedBox(height: 10),
        ],
      )),
    );
  }
}
