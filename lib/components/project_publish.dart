import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPublishButton extends StatefulWidget {
  const GetPublishButton({super.key});

  @override
  State<GetPublishButton> createState() => _GetPublishButtonState();
}

class _GetPublishButtonState extends State<GetPublishButton> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: (bool? v) {
                    setState(() {
                      if (v != null) {
                        value = v;
                      }
                    });
                  },
                ),
                Text(
                  "I confirm the data is correct",
                  style: ClanChurnTypography.font18500,
                ),
              ],
            ),
            ClanChurnSpacing.h20,
            // Container(
            //     width: 900,
            //     child: SelectableText(
            //         "${state.createdProject!.latestInputModel}")),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: value
                        ? () {
                            if (state.createdProject?.latestInputModel
                                    ?.inputStatus ==
                                LatestInputStatus.uploadedDataHasErrors) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(08),
                                    ),
                                    title: const Text(
                                        "Upload sheet has errors......."),
                                  );
                                },
                              );
                            } else if (state.createdProject?.latestInputModel
                                    ?.inputStatus ==
                                LatestInputStatus.uploadedDataHasNoErrors) {
                              context
                                  .read<ProjectArchitectBloc>()
                                  .add(GenerateMartsEvent(
                                    inputId: context
                                            .read<ProjectArchitectBloc>()
                                            .state
                                            .createdProject!
                                            .latestInput ??
                                        "",
                                    onSuccessCallback: (message) {},
                                    onErrorCallback: (errorMessage, errorCode) {
                                      print(" Marts Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
                                      GetDialog.failedErrorReport(context);
                                    },
                                  ));
                            }
                          }
                        : null,
                    child: Row(
                      children: [
                        Text(
                          "Publish",
                          style: ClanChurnTypography.font18600,
                        ),
                        ClanChurnSpacing.w10,
                        const Icon(Icons.arrow_circle_right_outlined),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
