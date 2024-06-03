import 'dart:convert';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadNewData extends StatefulWidget {
  const UploadNewData({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<UploadNewData> createState() => _UploadNewDataState();
}

class _UploadNewDataState extends State<UploadNewData> {
  List<Map<String, dynamic>> a = [];

  // Recursive function to convert nested JSON objects to lists of maps
  List<Map<String, dynamic>> jsonToList(Map<String, dynamic> json) {
    return json.entries.map((entry) {
      var value = entry.value;
      if (value is Map<String, dynamic>) {
        value = jsonToList(value); // Recursively convert nested objects
      }
      return {'name': entry.key, 'value': value};
    }).toList();
  }

  @override
  void initState() {
    if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
      if (context
              .read<ProjectArchitectBloc>()
              .state
              .createdProject!
              .latestInput !=
          null) {
        context.read<ProjectArchitectBloc>().add(GetInputExcelSummaryEvent(
              inputId: context
                  .read<ProjectArchitectBloc>()
                  .state
                  .createdProject!
                  .latestInput!,
              onErrorCallback: (errorMessage, errorCode) {},
              onSuccessCallback: (message) {
                print("Get Input Excel Summary: ${json.decode(message!.body)}");
                setState(() {
                  
                });
              },
            ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: widget.onPressed,
                ),
                ClanChurnSpacing.w10,
                SelectableText(
                  "Upload New Data",
                  style: ClanChurnTypography.font18600,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText("${state.createdProject!.latestInput}"),
                  InkWell(
                      onTap: () async {
                        if (kIsWeb) {
                          FilePickerResult? picked =
                              await FilePickerWeb.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['xls', 'xlsx'],
                          );

                          if (picked != null) {
                            // ignore: use_build_context_synchronously
                            context.read<ProjectArchitectBloc>().add(
                                  // ignore: use_build_context_synchronously
                                  UploadFileEvent(
                                    filePickerResult: picked,
                                    context: context,
                                    // ignore: use_build_context_synchronously
                                    projectId: context
                                        .read<ProjectArchitectBloc>()
                                        .state
                                        .createdProject!
                                        .id,
                                    onErrorCallback: (message, errorCode) {
                                      ApiRepository().handleWarningMessage(
                                          message, context, errorCode);
                                    },
                                    onSuccessCallBack: (message) {
                                      ApiRepository().handleSuccessMessage(
                                          "File uploaded successfully!....",
                                          context);
                                    },
                                  ),
                                );
                          }
                        }
                      },
                      child: Image.asset(
                        "assets/upload.png",
                        scale: 2,
                      )),
                  ClanChurnSpacing.h30,
                  state.errorReport == null
                      ? Container()
                      : ElevatedButton(
                          child: const Text("Download error report"),
                          onPressed: () {
                            final b = state.errorReport!;
                            launchURL(b);
                          },
                        )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
