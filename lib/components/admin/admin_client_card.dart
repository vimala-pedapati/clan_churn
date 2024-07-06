import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/admin/update_client_body.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminClientCard extends StatelessWidget {
  const AdminClientCard({super.key, required this.client});
  final ClientDetails client;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          height: 190,
          width: 160,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: state.isNotExpanded ? 40 : 35,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${client.image}",
                      // loadingBuilder: ((context, child, loadingProgress) {
                      //   return const CircularProgressIndicator();
                      // }),
                      errorBuilder: (context, error, stackTrace) {
                        return ClipOval(
                            child: Image.network(
                          image,
                          scale: 2,
                        ));
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      client.name,
                      style: ClanChurnTypography.font15600,
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
                      "Edit",
                      style: ClanChurnTypography.font15600,
                    ),
                    onPressed: () {
                      updateClient(context, client);
                    },
                  ),
                )
              ]),
        );
      },
    );
  }
}

void updateClient(BuildContext context, ClientDetails updateClient) {
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
        child: UpdateClientBody(
          updateClient: updateClient,
        ),
      ),
    ),
  );
}

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Container(
          height: 190,
          width: 160,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: state.isNotExpanded ? 40 : 35,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${user.image}",
                      // loadingBuilder: ((context, child, loadingProgress) {
                      //   return const CircularProgressIndicator();
                      // }),
                      errorBuilder: (context, error, stackTrace) {
                        return ClipOval(
                            child: Image.network(
                          image,
                          scale: 2,
                        ));
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      user.firstName ?? '',
                      style: ClanChurnTypography.font15600,
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
                      "Edit",
                      style: ClanChurnTypography.font15600,
                    ),
                    onPressed: () {},
                  ),
                )
              ]),
        );
      },
    );
  }
}
