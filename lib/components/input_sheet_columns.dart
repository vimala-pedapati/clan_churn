import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void downloadFile(String url, BuildContext context) async {
  try {
    // Send an HTTP request to the URL
    http.Response response = await http.get(Uri.parse(url));

    // Get the file name from the URL
    String fileName = url.split('/').last;

    // Create a blob from the response body
    Blob blob = Blob([response.bodyBytes]);

    // Create an anchor element
    AnchorElement anchorElement =
        AnchorElement(href: Url.createObjectUrlFromBlob(blob));
    anchorElement.download = fileName;
    anchorElement.click(); // initiate download
  } catch (e) {
    log("Error downloading file: $e");
  }
  // ignore: use_build_context_synchronously
  GoRouter.of(context).go(AppRoutes.home);
}

class ColumnsToChooseWidget extends StatelessWidget {
  const ColumnsToChooseWidget(
      {super.key, required this.projectName, required this.onBackPressed});
  final String projectName;
  final Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_backspace_outlined),
                  onPressed: onBackPressed,
                ),
                ClanChurnSpacing.w20,
                Text(
                  "Columns to choose",
                  style: ClanChurnTypography.font18600,
                ),
              ],
            ),

            // ClanChurnSpacing.h10,
            Expanded(
              child: AbsorbPointer(
                absorbing: projectName.isEmpty,
                child: Opacity(
                  // opacity: (projectName.isEmpty) ? 0.4 : 1.0,
                  opacity: (projectName.isEmpty || state.createdProject == null)
                      ? 0.4
                      : (state.createdProject!.id.isEmpty)
                          ? 0.4
                          : 1.0,
                  child: InputSheetColumns(
                      columnsList: state.columnsList,
                      customerColumnNames: state.customerColumnNames),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed:
                      (projectName.isEmpty || state.createdProject == null)
                          ? null
                          : (state.createdProject!.id.isEmpty)
                              ? null
                              : () {
                                  context
                                      .read<ProjectArchitectBloc>()
                                      .add(AddColumnsToProjectEvent());
                                  GetDialog.showDownloadDialog(context);
                                },
                  child: const Text("Next"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class InputSheetColumns extends StatelessWidget {
  final List<ColumnDetails> columnsList;
  final List<TextEditingController> customerColumnNames;

  const InputSheetColumns({
    Key? key,
    required this.columnsList,
    required this.customerColumnNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Grouping the columns by sheetName
    Map<String, List<ColumnDetails>> groupedColumns =
        groupBySheetName(columnsList);

    return SingleChildScrollView(
      child: Column(
        children: groupedColumns.entries.map((entry) {
          String sheetName = entry.key;
          List<ColumnDetails> columns = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "\n $sheetName",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 0,
                runSpacing: 0,
                children: List.generate(columns.length, (index) {
                  ColumnDetails column = columns[index];
                  int globalIndex = columnsList.indexOf(column);
                  return Row(
                    children: [
                      Checkbox(
                        value: column.isUserCheckedIn,
                        onChanged: column.isMandatory
                            ? null
                            : (value) {
                                ColumnDetails updatedColumn =
                                    column.copyWith(isUserCheckedIn: value);
                                List<ColumnDetails> updatedList =
                                    columnsList.toList();
                                updatedList[globalIndex] = updatedColumn;
                                context.read<ProjectArchitectBloc>().add(
                                    ReplaceColumnsEvent(
                                        columns: updatedList,
                                        index: globalIndex));
                              },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                column.columnName,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 300,
                              child: TextFormField(
                                controller: customerColumnNames[globalIndex],
                                enabled: column.isUserCheckedIn,
                                cursorHeight: 15,
                                onChanged: (value) {
                                  // Update the text of the controller
                                  // customerColumnNames[globalIndex].text = value;

                                  // Get the current cursor position
                                  // int cursorPosition = value.length;

                                  // Update the selection of the controller
                                  // customerColumnNames[globalIndex].selection =
                                  //     TextSelection.collapsed(
                                  //         offset: cursorPosition);

                                  // Dispatch an event to update the state with the modified list of controllers
                                  customerColumnNames.replaceRange(
                                      globalIndex,
                                      globalIndex + 1,
                                      [TextEditingController(text: value)]);
                                  for (var i in customerColumnNames) {
                                    print(i);
                                  }

                                  // context.read<ProjectArchitectBloc>().add(
                                  //       CustomerColumnNamesEvent(
                                  //           customerColumnNames:
                                  //               customerColumnNames),
                                  //     );
                                },
                                onEditingComplete: () {
                                  for (var i in customerColumnNames) {
                                    print(i);
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "$globalIndex ${column.id}",
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    border: const OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Function to group ColumnDetails by sheetName
  Map<String, List<ColumnDetails>> groupBySheetName(
      List<ColumnDetails> columns) {
    Map<String, List<ColumnDetails>> groupedColumns = {};
    for (var column in columns) {
      if (!groupedColumns.containsKey(column.sheetName)) {
        groupedColumns[column.sheetName] = [];
      }
      groupedColumns[column.sheetName]?.add(column);
    }
    return groupedColumns;
  }
}
