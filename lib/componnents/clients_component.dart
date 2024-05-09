import 'package:clan_churn/componnents/clients_card.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class ClientsComponent extends StatefulWidget {
  const ClientsComponent({super.key});

  @override
  State<ClientsComponent> createState() => _ClientsComponentState();
}

class _ClientsComponentState extends State<ClientsComponent> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.82,
      width: w * 0.8,
      margin: EdgeInsets.only(left: w * 0.025, right: w * 0.025, top: 20, bottom: 20),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(30)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Clients",
          style: ClanChurnTypography.font24600,
        ),
        ClanChurnSpacing.hw30,
        Expanded(
          child: SingleChildScrollView(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              itemCount: 20,
              itemBuilder: (context, index) {
                return const ClientsCard();
              },
            ),
          ),
        )
      ]),
    );
  }
}
