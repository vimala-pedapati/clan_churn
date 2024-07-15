
import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/project_card.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinetProjectViewCard extends StatelessWidget {
  const ClinetProjectViewCard(
      {super.key, required this.project, required this.client});
  final Project project;
  final ClientDetails client;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width*0.5,
      // padding: const EdgeInsets.all(08),
      margin: const EdgeInsets.all(08),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: Padding(
              padding: const EdgeInsets.all(0),
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
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name ?? '',
                      style: ClanChurnTypography.font14600,
                    ),
                    Text(
                      client.role ?? '',
                      style: ClanChurnTypography.font12600,
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 8, right: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    context.read<ClientBloc>().add(ArchiveProjectEvent(
                          projectId: project.id,
                          onErrorCallback: (errorMessage, errorCode) {
                            print(
                                "archieve project error: $errorCode, $errorMessage");
                          },
                          onSuccessCallback: (message) {
                            print("project archieve success ${message?.body}");
                            context
                                .read<ProjectArchitectBloc>()
                                .add(GetProjectsListEvent(clientId: client.id));
                          },
                        ));
                  },
                  child: const Text('archive'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
