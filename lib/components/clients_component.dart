import 'dart:convert';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/clients_card.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                SelectableText(
                  "Clients",
                  style: ClanChurnTypography.font24600,
                ),
               
              ],
            ),
            ClanChurnSpacing.hw30,
            Expanded(
                child: state.clientListLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : state.clientList.isEmpty
                        ? const Center(
                            child: Text("No Clients Found"),
                          )
                        : SingleChildScrollView(
                            child: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                              builder: (context, state) {
                                return Wrap(
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: state.clientList.map((c) {
                                    return ClientsCard(
                                      client: c,
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          )
                //  SingleChildScrollView(
                //   child: GridView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: HomePageRespUi.getCount(
                //             context: context, isNotExpanded: state.isNotExpanded),
                //         childAspectRatio: 1,
                //         crossAxisSpacing: 15,
                //         mainAxisSpacing: 15),
                //     itemCount: state.clientList.length,
                //     itemBuilder: (context, index) {
                //       return ClientsCard(
                //         index: index,
                //       );
                //     },
                //   ),
                // ),
                )
          ]),
        );
      },
    );
  }
}
