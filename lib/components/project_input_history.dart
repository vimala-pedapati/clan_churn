import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showHistory(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ClanChurnSpacing.w10,
                      SelectableText(
                        "History",
                        style: ClanChurnTypography.font24600,
                      ),
                    ],
                  ),
                ],
              ),
              ClanChurnSpacing.h20,
              const HistoryBody()
            ],
          ),
        ),
      ),
    ),
  );
}

class HistoryBody extends StatefulWidget {
  const HistoryBody({super.key});

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  void initState() {
    context.read<ProjectArchitectBloc>().add(ProjectInputHistoryEvent(
          projectId:
              context.read<ProjectArchitectBloc>().state.createdProject!.id,
          onErrorCallback: (errorMessage, errorCode) {
            print(
                "project input history error callback: $errorMessage $errorCode");
          },
          onSuccessCallback: (message) {
            print("project input history success callback: ${message!.body}");
          },
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 900,
      child: BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.projectHistory.length,
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.12),
                      borderRadius: BorderRadius.circular(05)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            ClanChurnSpacing.w20,
                            SizedBox(
                              // color: Colors.amber,
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.projectHistory[index].createdBy ==
                                            null
                                        ? "Not available"
                                        : "${state.projectHistory[index].createdBy!.firstName} ${state.projectHistory[index].createdBy!.lastName}",
                                    style: ClanChurnTypography.font18600
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                  ),
                                  Text(
                                    state.projectHistory[index].createdBy ==
                                            null
                                        ? "Not available"
                                        : state.projectHistory[index].createdBy!
                                            .userType,
                                    style: ClanChurnTypography.font14500
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                  )
                                ],
                              ),
                            ),
                            ClanChurnSpacing.w100,
                            Text(
                              "${state.projectHistory[index].inputStatus?.properValue}",
                              style: ClanChurnTypography.font18600.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                        SelectableText(
                          convertDateTime(state
                              .projectHistory[index].inputSheetUplodedTime
                              .toString()),
                          style: ClanChurnTypography.font18600.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ]),
                );
              });
        },
      ),
    );
  }
}

String convertDateTime(String input) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(input);

  // Manually adjust the date and time to the expected values
  DateTime adjustedDate = DateTime(parsedDate.year, parsedDate.month,
      parsedDate.day, parsedDate.hour, parsedDate.minute);

  // Format the DateTime object to the desired output string
  DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  String formattedDate = formatter.format(adjustedDate);

  // Modify AM/PM format to be uppercase and include period
  formattedDate = formattedDate.replaceAll('AM', 'A.M').replaceAll('PM', 'P.M');

  return formattedDate;
}
