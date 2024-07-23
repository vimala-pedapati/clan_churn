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
                  onPressed: (projectName.isEmpty ||
                          state.createdProject == null)
                      ? null
                      : (state.createdProject!.id.isEmpty)
                          ? null
                          : () {
                              context
                                  .read<ProjectArchitectBloc>()
                                  .add(AddColumnsToProjectEvent(
                                    onErrorCallback:
                                        (errorMessage, errorCode) {},
                                    onSuccessCallback: (message) {
                                      context.read<ProjectArchitectBloc>().add(
                                          GetProjectsListEvent(
                                              clientId: context
                                                  .read<ProjectArchitectBloc>()
                                                  .state
                                                  .selectedClient!
                                                  .id));
                                    },
                                  ));

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
                        onChanged: column.isMandatory &&
                                !hasDependentColumns(column, columnsList)
                            ? null
                            : (value) {
                                List<ColumnDetails> updatedList =
                                    columnsList.toList();
                                ColumnDetails updatedColumn =
                                    column.copyWith(isUserCheckedIn: value);

                                // Update the current column
                                updatedList[globalIndex] = updatedColumn;

                                // Define the dependencies
                                Set<String> set1 = {
                                  '6643391d355afb7ee8285ebc', // Performance Value Target
                                  '664338ec355afb7ee8285eba', // Actual Performance Value
                                };
                                Set<String> set2 = {
                                  '6643390b355afb7ee8285ebb', // Performance Quantity Target
                                  '66433931355afb7ee8285ebd', // Actual Performance Quantity
                                };

                                // Function to check if at least one set is selected
                                bool isValidSelection(
                                    List<ColumnDetails> columns) {
                                  bool set1Selected = set1.any((id) => columns
                                      .firstWhere((col) => col.id == id)
                                      .isUserCheckedIn);
                                  bool set2Selected = set2.any((id) => columns
                                      .firstWhere((col) => col.id == id)
                                      .isUserCheckedIn);
                                  return set1Selected || set2Selected;
                                }

                                // Check if the column is mandatory and does not have dependencies
                                if (column.isMandatory &&
                                    !hasDependentColumns(column, columnsList)) {
                                  // Allow only if mandatory and no dependencies
                                  return;
                                }

                                // Check if unselecting is valid
                                if (value == false) {
                                  // Uncheck dependent columns if unchecked
                                  updatedList = handleDependencies(
                                      updatedList, updatedColumn.id, false);

                                  // Check if remaining columns satisfy the condition
                                  if (!isValidSelection(updatedList)) {
                                    // Show a warning message if not valid
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Warning'),
                                        content: const Text(
                                          'Please select at least one column from each of the following groups to proceed:\n\n'
                                          '1. Performance Value Target and Actual Performance Value, or\n'
                                          '2. Performance Quantity Target and Actual Performance Quantity.\n\n'
                                          'Ensure that at least one column from each group is checked.',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    return; // Exit the method to prevent unselecting
                                  }
                                } else {
                                  // Check dependent columns if checked
                                  updatedList = handleDependencies(
                                      updatedList, updatedColumn.id, true);
                                }

                                context.read<ProjectArchitectBloc>().add(
                                    ReplaceColumnsEvent(
                                        columns: updatedList,
                                        index: globalIndex));
                              },
                      ),
                      // Checkbox(
                      //   value: column.isUserCheckedIn,
                      //   onChanged: column.isMandatory &&
                      //           !hasDependentColumns(column, columnsList)
                      //       ? null
                      //       : (value) {
                      //           List<ColumnDetails> updatedList =
                      //               columnsList.toList();
                      //           ColumnDetails updatedColumn =
                      //               column.copyWith(isUserCheckedIn: value);

                      //           // Update the current column
                      //           updatedList[globalIndex] = updatedColumn;

                      //           // Handle dependencies
                      //           if (value == false) {
                      //             // Uncheck dependent columns if unchecked
                      //             updatedList = handleDependencies(
                      //                 updatedList, updatedColumn.id, false);
                      //           } else {
                      //             // Check dependent columns if checked
                      //             updatedList = handleDependencies(
                      //                 updatedList, updatedColumn.id, true);
                      //           }

                      //           context.read<ProjectArchitectBloc>().add(
                      //               ReplaceColumnsEvent(
                      //                   columns: updatedList,
                      //                   index: globalIndex));
                      //         },
                      // ),

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
                                  customerColumnNames[globalIndex].text = value;
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

  bool hasDependentColumns(ColumnDetails column, List<ColumnDetails> columns) {
    List<ColumnDetails> dependentColumns =
        columns.where((col) => col.depends == column.id).toList();
    return dependentColumns.isNotEmpty;
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

  List<ColumnDetails> handleDependencies(
      List<ColumnDetails> columnsList, String columnId, bool isChecked) {
    List<ColumnDetails> updatedList = columnsList.toList();

    for (int i = 0; i < updatedList.length; i++) {
      if (updatedList[i].depends == columnId) {
        updatedList[i] = updatedList[i].copyWith(isUserCheckedIn: isChecked);
        if (!isChecked) {
          // If unchecking, recursively uncheck dependents
          updatedList =
              handleDependencies(updatedList, updatedList[i].id, false);
        }
      }
    }

    return updatedList;
  }
}

// class InputSheetColumns extends StatelessWidget {
//   final List<ColumnDetails> columnsList;
//   final List<TextEditingController> customerColumnNames;

//   const InputSheetColumns({
//     Key? key,
//     required this.columnsList,
//     required this.customerColumnNames,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Grouping the columns by sheetName
//     Map<String, List<ColumnDetails>> groupedColumns =
//         groupBySheetName(columnsList);

//     return SingleChildScrollView(
//       child: Column(
//         children: groupedColumns.entries.map((entry) {
//           String sheetName = entry.key;
//           List<ColumnDetails> columns = entry.value;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   "\n $sheetName",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Wrap(
//                 spacing: 0,
//                 runSpacing: 0,
//                 children: List.generate(columns.length, (index) {
//                   ColumnDetails column = columns[index];
//                   int globalIndex = columnsList.indexOf(column);
//                   return Row(
//                     children: [
//                       Checkbox(
//                         value: column.isUserCheckedIn,
//                         onChanged: column.isMandatory
//                             ? null
//                             : (value) {
//                                 ColumnDetails updatedColumn =
//                                     column.copyWith(isUserCheckedIn: value);
//                                 List<ColumnDetails> updatedList =
//                                     columnsList.toList();
//                                 updatedList[globalIndex] = updatedColumn;
//                                 context.read<ProjectArchitectBloc>().add(
//                                     ReplaceColumnsEvent(
//                                         columns: updatedList,
//                                         index: globalIndex));
//                               },
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 column.columnName,
//                                 overflow: TextOverflow.visible,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                               width: 300,
//                               child: TextFormField(
//                                 controller: customerColumnNames[globalIndex],
//                                 enabled: column.isUserCheckedIn,
//                                 cursorHeight: 15,
//                                 onChanged: (value) {
//                                   // Update the text of the controller
//                                   // customerColumnNames[globalIndex].text = value;

//                                   // Get the current cursor position
//                                   // int cursorPosition = value.length;

//                                   // Update the selection of the controller
//                                   // customerColumnNames[globalIndex].selection =
//                                   //     TextSelection.collapsed(
//                                   //         offset: cursorPosition);

//                                   // Dispatch an event to update the state with the modified list of controllers
//                                   customerColumnNames.replaceRange(
//                                       globalIndex,
//                                       globalIndex + 1,
//                                       [TextEditingController(text: value)]);
//                                   for (var i in customerColumnNames) {
//                                     print(i);
//                                   }

//                                   // context.read<ProjectArchitectBloc>().add(
//                                   //       CustomerColumnNamesEvent(
//                                   //           customerColumnNames:
//                                   //               customerColumnNames),
//                                   //     );
//                                 },
//                                 onEditingComplete: () {
//                                   for (var i in customerColumnNames) {
//                                     print(i);
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                     hintText: "$globalIndex ${column.id}",
//                                     contentPadding: const EdgeInsets.only(
//                                         left: 10, right: 10),
//                                     border: const OutlineInputBorder()),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   // Function to group ColumnDetails by sheetName
//   Map<String, List<ColumnDetails>> groupBySheetName(
//       List<ColumnDetails> columns) {
//     Map<String, List<ColumnDetails>> groupedColumns = {};
//     for (var column in columns) {
//       if (!groupedColumns.containsKey(column.sheetName)) {
//         groupedColumns[column.sheetName] = [];
//       }
//       groupedColumns[column.sheetName]?.add(column);
//     }
//     return groupedColumns;
//   }
// }
// import 'dart:developer';
// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

// import 'package:clan_churn/api_repos/models/column_model.dart';
// import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
// import 'package:clan_churn/components/dialogs.dart';
// import 'package:clan_churn/utils/routes.dart';
// import 'package:clan_churn/utils/spacing.dart';
// import 'package:clan_churn/utils/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// Future<void> launchURL(String url) async {
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// void downloadFile(String url, BuildContext context) async {
//   try {
//     // Send an HTTP request to the URL
//     http.Response response = await http.get(Uri.parse(url));

//     // Get the file name from the URL
//     String fileName = url.split('/').last;

//     // Create a blob from the response body
//     Blob blob = Blob([response.bodyBytes]);

//     // Create an anchor element
//     AnchorElement anchorElement =
//         AnchorElement(href: Url.createObjectUrlFromBlob(blob));
//     anchorElement.download = fileName;
//     anchorElement.click(); // initiate download
//   } catch (e) {
//     log("Error downloading file: $e");
//   }
//   // ignore: use_build_context_synchronously
//   GoRouter.of(context).go(AppRoutes.home);
// }

// class ColumnsToChooseWidget extends StatelessWidget {
//   const ColumnsToChooseWidget(
//       {super.key, required this.projectName, required this.onBackPressed});
//   final String projectName;
//   final Function() onBackPressed;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
//       builder: (context, state) {
//         return Column(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.keyboard_backspace_outlined),
//                   onPressed: onBackPressed,
//                 ),
//                 ClanChurnSpacing.w20,
//                 Text(
//                   "Columns to choose",
//                   style: ClanChurnTypography.font18600,
//                 ),
//               ],
//             ),

//             // ClanChurnSpacing.h10,
//             Expanded(
//               child: AbsorbPointer(
//                 absorbing: projectName.isEmpty,
//                 child: Opacity(
//                   // opacity: (projectName.isEmpty) ? 0.4 : 1.0,
//                   opacity: (projectName.isEmpty || state.createdProject == null)
//                       ? 0.4
//                       : (state.createdProject!.id.isEmpty)
//                           ? 0.4
//                           : 1.0,
//                   child: InputSheetColumns(
//                       columnsList: state.columnsList,
//                       customerColumnNames: state.customerColumnNames),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed:
//                       (projectName.isEmpty || state.createdProject == null)
//                           ? null
//                           : (state.createdProject!.id.isEmpty)
//                               ? null
//                               : () {
//                                   context
//                                       .read<ProjectArchitectBloc>()
//                                       .add(AddColumnsToProjectEvent());
//                                   GetDialog.showDownloadDialog(context);
//                                 },
//                   child: const Text("Next"),
//                 ),
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }
// }

// class InputSheetColumns extends StatelessWidget {
//   final List<ColumnDetails> columnsList;
//   final List<TextEditingController> customerColumnNames;

//   const InputSheetColumns({
//     Key? key,
//     required this.columnsList,
//     required this.customerColumnNames,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Grouping the columns by sheetName
//     Map<String, List<ColumnDetails>> groupedColumns =
//         groupBySheetName(columnsList);

//     return SingleChildScrollView(
//       child: Column(
//         children: groupedColumns.entries.map((entry) {
//           String sheetName = entry.key;
//           List<ColumnDetails> sheetWiseCols = entry.value;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   "\n $sheetName",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Wrap(
//                 spacing: 0,
//                 runSpacing: 0,
//                 children: List.generate(sheetWiseCols.length, (index) {
//                   ColumnDetails column = sheetWiseCols[index];
//                   int globalIndex = columnsList.indexOf(column);
//                   return Row(
//                     children: [
//                       Checkbox(
//                         value: column.isUserCheckedIn,
//                         onChanged: checkMandatoryAndDepExistsOrNot(
//                                 column, columnsList)
//                             ? null
//                             : (value) {
//                                 ColumnDetails updCol =  column.copyWith(isUserCheckedIn: value);
//                                 List<ColumnDetails> updList = columnsList.toList();
//                                 updList[globalIndex] = updCol;
//                                 if (getIndOfDepCol(column, sheetWiseCols) != null) {
//                                   //  ColumnDetails updDepCol =  updList[getIndOfDepCol(column, columnsList)!].copyWith(isUserCheckedIn: value);
//                                   //   List<ColumnDetails> updDepList = updList.toList();
//                                   //   updDepList[getIndOfDepCol(column, sheetWiseCols)!] = updDepCol;
//                                   //  context.read<ProjectArchitectBloc>().add( ReplaceColumnsEvent( columns: updDepList));
                                 
//                                 } 
//                                   context.read<ProjectArchitectBloc>().add( ReplaceColumnsEvent( columns: updList));
                                
//                               },
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 "${column.columnName} ${getIndOfDepCol(column, sheetWiseCols)} ${checkMandatoryAndDepExistsOrNot(column, columnsList)}",
//                                 overflow: TextOverflow.visible,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                               width: 300,
//                               child: TextFormField(
//                                 controller: customerColumnNames[globalIndex],
//                                 enabled: column.isUserCheckedIn,
//                                 cursorHeight: 15,
//                                 onChanged: (value) {
//                                   // Update the text of the controller
//                                   // customerColumnNames[globalIndex].text = value;

//                                   // Get the current cursor position
//                                   // int cursorPosition = value.length;

//                                   // Update the selection of the controller
//                                   // customerColumnNames[globalIndex].selection =
//                                   //     TextSelection.collapsed(
//                                   //         offset: cursorPosition);

//                                   // Dispatch an event to update the state with the modified list of controllers
//                                   customerColumnNames.replaceRange(
//                                       globalIndex,
//                                       globalIndex + 1,
//                                       [TextEditingController(text: value)]);
//                                   for (var i in customerColumnNames) {
//                                     print(i);
//                                   }

//                                   // context.read<ProjectArchitectBloc>().add(
//                                   //       CustomerColumnNamesEvent(
//                                   //           customerColumnNames:
//                                   //               customerColumnNames),
//                                   //     );
//                                 },
//                                 onEditingComplete: () {
//                                   for (var i in customerColumnNames) {
//                                     print(i);
//                                   }
//                                 },
//                                 decoration: InputDecoration(
//                                     hintText: "$globalIndex ${column.id}",
//                                     contentPadding: const EdgeInsets.only(
//                                         left: 10, right: 10),
//                                     border: const OutlineInputBorder()),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   // Function to group ColumnDetails by sheetName
//   Map<String, List<ColumnDetails>> groupBySheetName(
//       List<ColumnDetails> columns) {
//     Map<String, List<ColumnDetails>> groupedColumns = {};
//     for (var column in columns) {
//       if (!groupedColumns.containsKey(column.sheetName)) {
//         groupedColumns[column.sheetName] = [];
//       }
//       groupedColumns[column.sheetName]?.add(column);
//     }
//     return groupedColumns;
//   }
// }

// List<ColumnDetails> hasDependentColumns(
//     ColumnDetails column, List<ColumnDetails> columns) {
//   List<ColumnDetails> dependentColumns =
//       columns.where((col) => col.depends == column.id).toList();
//   return dependentColumns;
// }

// bool checkMandatoryAndDepExistsOrNot(
//     ColumnDetails column, List<ColumnDetails> columns) {
//   if (column.isMandatory) {
//     if (hasDependentColumns(column, columns).isNotEmpty) {
//       return false;
//     }
//   }
//   return column.isMandatory;
// }

// int? getIndOfDepCol(ColumnDetails column, List<ColumnDetails> columns) {
//   List<ColumnDetails> filtedData = hasDependentColumns(column, columns);
//   if (filtedData.isNotEmpty) {
//     int dependentIndex = columns.indexOf(filtedData[0]);
//     return dependentIndex;
//   }
//   return null;
// }
