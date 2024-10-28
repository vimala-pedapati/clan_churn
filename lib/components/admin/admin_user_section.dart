import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/admin/update_user_form.dart';
import 'package:clan_churn/components/project_card.dart';
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
        Navigator.push(context, customPageRouteForNavigation(const CreateNewUser()));
      },
      child: Container(
        height: 230,
        width: 180,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.circular(10)),
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
  const UsersCard({
    super.key,
  });

  @override
  State<UsersCard> createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserDetailsEvent(context: context));
    context.read<UserBloc>().add(GetAllUsersEvent(
          onErrorCallback: (errorMessage, errorCode) {},
          onSuccessCallback: (message) {},
        ));
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
              ...state.listOfUsers.map((user) {
                return UserCard(
                  user: user,
                  index: state.listOfUsers.indexOf(user),
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
  const CreateNewUserButton({super.key, required this.user});
  final User user;

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

void updateUser(BuildContext context, User user, int index) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(08),
      ),
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(0.0),
        )),
        child: UpdateUser(
          user: user,
          index: index,
        ),
      ),
    ),
  );
}

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, this.index});
  final User user;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          height: 230,
          width: 180,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.circular(10)),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ClipOval(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.background,
                backgroundImage: NetworkImage(image),
                foregroundImage: NetworkImage(
                  "${user.image}",
                  // loadingBuilder: ((context, child, loadingProgress) {
                  //   return const CircularProgressIndicator();
                  // }),
                  // errorBuilder: (context, error, stackTrace) {
                  //   return ClipOval(
                  //       child: Image.network(
                  //     image,
                  //     scale: 2,
                  //   ));
                  // },
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  user.firstName ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: ClanChurnTypography.font15600,
                ),
              ],
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.only(left: 20, right: 20), shape: const StadiumBorder()),
                child: Text(
                  "Edit",
                  style: ClanChurnTypography.font15600,
                ),
                onPressed: () {
                  if (index != null) {
                    updateUser(context, user, index!);
                  }
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
