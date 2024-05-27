import 'package:flutter/material.dart';

class ClanChurnAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ClanChurnAppBar({super.key});

  @override
  State<ClanChurnAppBar> createState() => _ClanChurnAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _ClanChurnAppBarState extends State<ClanChurnAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,  
      title: IntrinsicHeight(
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
      actions: const [
        CircleAvatar(
          radius: 50,
          child: Icon(Icons.notifications),
        )
      ],
    );
  }
}
