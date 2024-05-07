import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class ClientsCard extends StatelessWidget {
  const ClientsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 160,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(Icons.person),
        ),
        Column(
          children: [
            Text(
              "Piramal",
              style: ClanChurnTypography.font15600,
            ),
            Text(
              "Home Loans",
              style: ClanChurnTypography.font12500,
            ),
          ],
        ),
        SizedBox(
          width: 160,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 20, right: 20),
                shape: const StadiumBorder()),
            child: Text(
              "View",
              style: ClanChurnTypography.font15600,
            ),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
