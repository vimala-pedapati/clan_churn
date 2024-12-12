import 'dart:convert';

import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../utils/routes.dart';

class ClientsCard extends StatelessWidget {
  const ClientsCard({super.key, required this.client});
  final ClientDetails client;

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
            CircleAvatar(
              radius: state.isNotExpanded ? 40 : 35,
              backgroundColor: Theme.of(context).colorScheme.background,
              onForegroundImageError: (context, error) {
                ClipOval(
                    child: Image.network(
                  image,
                  scale: 2,
                ));
              },
              foregroundImage: NetworkImage(
                "${client.image}",
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  client.name,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: ClanChurnTypography.font15600,
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.only(left: 20, right: 20), shape: const StadiumBorder()),
                child: Text(
                  "View",
                  style: ClanChurnTypography.font15600,
                ),
                onPressed: () {
                  context.read<ProjectArchitectBloc>().add(SetSelectedClientEvent(selectedClient: client));
                  final clientDetailsJson = json.encode(client.toJson());
                  final encodedClientDetails = Uri.encodeComponent(clientDetailsJson);
                  context.push(
                    '${AppRoutes.home}/${client.name}/${AppRoutes.projects}',
                    extra: {
                      "clientDetails": encodedClientDetails,
                    },
                  );
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
