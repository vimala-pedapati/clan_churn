 
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return // profile and logo bar
        Stack(
      children: [
        Container(
          height: h * 0.1,
          color: Theme.of(context).colorScheme.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
             
            ],
          ),
        ),
        

      ],
    );
  }
}
