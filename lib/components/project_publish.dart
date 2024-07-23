// import 'package:clan_churn/api_repos/models/project_model.dart';
// import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
// import 'package:clan_churn/components/dialogs.dart';
// import 'package:clan_churn/utils/spacing.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GetPublishButton extends StatefulWidget {
//   const GetPublishButton({super.key});

//   @override
//   State<GetPublishButton> createState() => _GetPublishButtonState();
// }

// class _GetPublishButtonState extends State<GetPublishButton> {
//   bool value = false;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Row(
//               children: [
//                 Checkbox(
//                   value: value,
//                   onChanged: (bool? v) {
//                     setState(() {
//                       if (v != null) {
//                         value = v;
//                       }
//                     });
//                   },
//                 ),
//                 Text(
//                   "I confirm the data is correct",
//                   style: ClanChurnTypography.font18500,
//                 ),
//               ],
//             ),
//             ClanChurnSpacing.h20,
//             // Container(
//             //     width: 900,
//             //     child: SelectableText(
//             //         "${state.createdProject!.latestInputModel}")),
//             Row(
//               children: [
//                 SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: value
//                         ? () {
//                             if (state.createdProject?.latestInputModel
//                                     ?.inputStatus ==
//                                 InputStatus.uploadedDataHasErrors) {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     backgroundColor: Theme.of(context)
//                                         .colorScheme
//                                         .background,
//                                     surfaceTintColor: Colors.transparent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(08),
//                                     ),
//                                     title: const Text(
//                                         "Upload sheet has errors......."),
//                                   );
//                                 },
//                               );
//                             } else if (state.createdProject?.latestInputModel
//                                     ?.inputStatus ==
//                                 InputStatus.uploadedDataHasNoErrors) {
//                               context
//                                   .read<ProjectArchitectBloc>()
//                                   .add(GenerateMartsEvent(
//                                     inputId: context
//                                             .read<ProjectArchitectBloc>()
//                                             .state
//                                             .createdProject!
//                                             .latestInput ??
//                                         "",
//                                     onSuccessCallback: (message) {},
//                                     onErrorCallback: (errorMessage, errorCode) {
//                                       print(" Marts Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
//                                       GetDialog.failedErrorReport(context);
//                                     },
//                                   ));
//                             }
//                           }
//                         : null,
//                     child: Row(
//                       children: [
//                         Text(
//                           "Publish",
//                           style: ClanChurnTypography.font18600,
//                         ),
//                         ClanChurnSpacing.w10,
//                         const Icon(Icons.arrow_circle_right_outlined),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }
// }

import 'dart:convert';

import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/components/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';

/// Widget representing a Publish Button with stateful behavior.
class GetPublishButton extends StatefulWidget {
  const GetPublishButton({Key? key}) : super(key: key);
  @override
  State<GetPublishButton> createState() => _GetPublishButtonState();
}

/// State class for [GetPublishButton].
class _GetPublishButtonState extends State<GetPublishButton> {
  bool value = false; // Initial value for checkbox

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Column(
          children: [
            // Checkbox and confirmation text row
            buildCheckboxRow(),
            ClanChurnSpacing.h20,
            // Container for displaying latest input model (commented out)
            // buildLatestInputContainer(state),
            // Publish button row
            buildPublishButtonRow(state),
          ],
        );
      },
    );
  }

  /// Builds the row containing a checkbox and confirmation text.
  Widget buildCheckboxRow() {
    return Row(
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
          style: ClanChurnTypography.font14900,
        ),
      ],
    );
  }

  /// Builds a container to display the latest input model (commented out).
  // Widget buildLatestInputContainer(ProjectArchitectState state) {
  //   return Container(
  //     width: 900,
  //     child: SelectableText("${state.createdProject!.latestInputModel}"),
  //   );
  // }

  /// Builds the row containing the Publish button.
  Widget buildPublishButtonRow(ProjectArchitectState state) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: value
                ? () {
                    // Check input status and perform actions accordingly
                    if (state.createdProject?.latestInputModel?.inputStatus ==
                        InputStatus.uploadedDataHasErrors) {
                      // Show dialog for error case
                      showDialog(
                        context: context,
                        builder: (context) => buildErrorDialog(context),
                      );
                    } else if (state.createdProject?.latestInputModel
                                ?.inputStatus ==
                            InputStatus.uploadedDataHasNoErrors ||
                        state.createdProject?.latestInputModel?.inputStatus ==
                            InputStatus.uploadedDataDataMartsGenerated) {
                      // Generate Marts event for successful case
                      context.read<ProjectArchitectBloc>().add(
                            GenerateMartsEvent(
                              inputId: state.createdProject!.latestInput ?? "",
                              onSuccessCallback: (message) {},
                              onErrorCallback: (errorMessage, errorCode) {
                                print(
                                    "Marts Report...${state.createdProject!.latestInput}..$errorMessage $errorCode");
                                GetDialog.failedErrorReport(
                                    context, errorMessage);
                              },
                            ),
                          );
                    }
                  }
                : null,
            child: Row(
              children: [
                Text(
                  "Publish",
                  style: ClanChurnTypography.font14900,
                ),
                ClanChurnSpacing.w10,
                const Icon(Icons.arrow_circle_right_outlined),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: value
                ? () {
                    // print("report ..........${state.createdProject?.latestInputModel?.inputStatus}");
                    // Check input status and perform actions accordingly
                    if (state.createdProject?.latestInputModel?.inputStatus ==
                        InputStatus.uploadedDataHasErrors) {
                      // Show dialog for error case
                      showDialog(
                        context: context,
                        builder: (context) => buildErrorDialog(context),
                      );
                    } else if (state.createdProject?.latestInputModel
                                ?.inputStatus ==
                            InputStatus.uploadedDataHasNoErrors ||
                        state.createdProject?.latestInputModel?.inputStatus ==
                            InputStatus.uploadedDataDataMartsGenerated) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PerformanceReport(
                              inputId: "666ad1898a6200fad12f7ae3",
                              reportName: "sample",
                            ),
                          ));
                    }
                  }
                : null,
            child: Row(
              children: [
                Text(
                  "Reports",
                  style: ClanChurnTypography.font14900,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds an AlertDialog for displaying an error dialog.
  Widget buildErrorDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(08),
      ),
      title: const Text("Upload sheet has errors......."),
    );
  }
}
