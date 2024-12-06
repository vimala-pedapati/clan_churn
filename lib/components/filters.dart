import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        height: 100,
        width: 38,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.7), width: 2),
          top: BorderSide(color: Theme.of(context).colorScheme.primary),
          bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
        )),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ColoredBox(color: Colors.transparent, child: Icon(Icons.filter_alt_outlined)),
            const SizedBox(
              height: 5,
            ),
            ColoredBox(
              color: Colors.transparent,
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "filters",
                    style: ClanChurnTypography.font16600.copyWith(height: 1),
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
