import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';

import 'package:clan_churn/components/clients_card.dart';
import 'package:clan_churn/utils/device_types.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsComponent extends StatefulWidget {
  const ClientsComponent({super.key});

  @override
  State<ClientsComponent> createState() => _ClientsComponentState();
}

class _ClientsComponentState extends State<ClientsComponent> {
  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return ChurnContainer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SelectableText(
              "Clients",
              style: ClanChurnTypography.font24600,
            ),
            ClanChurnSpacing.hw30,
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: HomePageRespUi.getCount(
                          context: context, isNotExpanded: state.isNotExpanded),
                      childAspectRatio: 1,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: state.clientList.length,
                  itemBuilder: (context, index) {
                    return ClientsCard(
                      index: index,
                    );
                  },
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}
