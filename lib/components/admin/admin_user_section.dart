import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/admin/admin_client_card.dart';
import 'package:clan_churn/pages/create_new_user.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewUserCard extends StatelessWidget {
  const CreateNewUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, customPageRouteForNavigation(const CreateNewUser()));
      },
      child: Container(
        height: 190,
        width: 160,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.add_circle_outline_outlined,
            size: 70,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Create New User",
            style: ClanChurnTypography.font12600,
          )
        ]),
      ),
    );
  }
}

class UsersCard extends StatefulWidget {
  const UsersCard({super.key});

  @override
  State<UsersCard> createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetailsEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Wrap(
            runSpacing: 15,
            spacing: 15,
            children: [
              ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((c) {
                return UserCard(
                  user: state.user!,
                );
              }).toList(),
              const CreateNewUserCard()
            ],
          );
        },
      ),
    );
  }
}

class CreateNewUserButton extends StatelessWidget {
  const CreateNewUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        children: [
          const Icon(Icons.person_add_outlined),
          const SizedBox(
            width: 10,
          ),
          FittedBox(
            child: Text(
              "Create New User",
              style: ClanChurnTypography.font15600,
            ),
          ),
        ],
      ),
    );
  }
}
