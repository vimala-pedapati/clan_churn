import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/admin/admin_client_card.dart';
import 'package:clan_churn/pages/create_new_client.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClientBody extends StatefulWidget {
  const CreateClientBody({super.key});

  @override
  State<CreateClientBody> createState() => _CreateClientBodyState();
}

class _CreateClientBodyState extends State<CreateClientBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create",
            style: ClanChurnTypography.font24600,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                builder: (context, state) {
                  return Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ...state.clientList.map((c) {
                        return AdminClientCard(
                          client: c,
                        );
                      }).toList(),
                      const CreateNewClientCard()
                    ],
                  );
                },
              ),
            ),
          )
        ]);
  }
}

class CreateNewClientCard extends StatelessWidget {
  const CreateNewClientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, customPageRouteForNavigation(const CreateNewClient()));
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
            "Create New Client",
            style: ClanChurnTypography.font12600,
          )
        ]),
      ),
    );
  }
}
