import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart'; 
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: h * 0.07,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30)),
          child: Row(children: [
            const Icon(
              Icons.expand_circle_down_outlined,
            ),
            ClanChurnSpacing.w5,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vishal Sharma",
                  style: ClanChurnTypography.font15600,
                ),
                Text(
                  "Project Head - Piramal",
                  style: ClanChurnTypography.font10600,
                )
              ],
            ),
            ClanChurnSpacing.w5,
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: const Icon(
                Icons.person,
              ),
            )
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            context.read<SignInBloc>().add(SignOutEvent(context: context));
          },
        ),
      ],
    );
  }
}
