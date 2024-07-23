import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/client_project_view_card.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProjects extends StatelessWidget {
  const ClientProjects(
      {super.key, required this.goToPreviousPage, required this.client});
  final Function() goToPreviousPage;
  final ClientDetails client;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: goToPreviousPage,
                    icon: const Icon(Icons.keyboard_backspace_outlined)),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Clinet Projects",
                  style: ClanChurnTypography.font20600,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.projectsList.length,
                // itemCount: 10,
                itemBuilder: (context, index) {
                  return ClinetProjectViewCard(
                    client: client,
                    project: state.projectsList[index],
                  );
                  // return Text("vimala kesireddy");
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
