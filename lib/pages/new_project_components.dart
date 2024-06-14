import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CreateNewProject extends StatelessWidget {
  const CreateNewProject({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return WrapProfile(
              child: Column(children: [
                // Nav bar
                const NavBar(),
                SizedBox(height: h * 0.01),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideBar(
                      selectedRoute: SelectedRoute.home,
                    ),
                    AddNewProjectComponent()
                  ],
                ),
              ]),
            );
          },
        ));
  }
}

class AddNewProjectComponent extends StatefulWidget {
  const AddNewProjectComponent({super.key});

  @override
  State<AddNewProjectComponent> createState() => _AddNewProjectComponentState();
}

class _AddNewProjectComponentState extends State<AddNewProjectComponent> {
  TextEditingController clientController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  String previousName = "";
  String projectName = "";
  bool isProjectCreated = false;

  @override
  void initState() {
    setState(() {
      clientController.text =
          context.read<ProjectArchitectBloc>().state.selectedClient!.name;
    });

    if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
      if (context
          .read<ProjectArchitectBloc>()
          .state
          .createdProject!
          .id
          .isNotEmpty) {
        isProjectCreated = true;
      }
      setState(() {
        projectController.text =
            context.read<ProjectArchitectBloc>().state.createdProject!.name ??
                '';
        projectName =
            context.read<ProjectArchitectBloc>().state.createdProject!.name ??
                '';
        previousName =
            context.read<ProjectArchitectBloc>().state.createdProject!.name ??
                '';
      });
    }
    context.read<ProjectArchitectBloc>().add(const GetColumnsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: state.isNotExpanded ? w * 0.89 : w * 0.8,
          height: h * 0.83,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(30)),
          margin: EdgeInsets.only(
              left: w * 0.025, right: w * 0.025, top: 10, bottom: 20),
          duration: const Duration(seconds: 1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // GoRouter.of(context).go(AppRoutes.home);
                      },
                    ),
                    ClanChurnSpacing.w10,
                    Text(
                      "Start New Project",
                      style: ClanChurnTypography.font18600,
                    ),
                  ],
                ),
                ClanChurnSpacing.h30,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Customer Name",
                                      style: ClanChurnTypography.font15900,
                                    ),
                                    Text(
                                      "*",
                                      style: ClanChurnTypography.font10600
                                          .copyWith(color: Colors.red),
                                    )
                                  ],
                                ),
                                Container(
                                  width: w * 0.25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 20),
                                  child: TextFormField(
                                    controller: clientController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    cursorHeight: 15,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Client ID',
                                      hintStyle: ClanChurnTypography.font12500
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    onChanged: (value) {},
                                    validator: (String? val) {
                                      return null;
                                    },
                                    onSaved: (String? val) {},
                                  ),
                                ),
                              ],
                            ),
                            ClanChurnSpacing.w20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Project Name",
                                  style: ClanChurnTypography.font15900,
                                ),
                                Container(
                                  width: w * 0.25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 20),
                                  child: TextFormField(
                                    controller: projectController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    cursorHeight: 15,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Project Name',
                                      hintStyle: ClanChurnTypography.font15400
                                          .copyWith(
                                              color:
                                                  Colors.grey.withOpacity(0.7)),
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        projectName = value;
                                      });
                                    },
                                    validator: (String? val) {
                                      return null;
                                    },
                                    onSaved: (String? val) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: (projectName.isEmpty ||
                                  state.columnsList.isEmpty ||
                                  projectName == previousName)
                              ? null
                              : () {
                                  if (isProjectCreated) {
                                    context.read<ProjectArchitectBloc>().add(
                                        UpdateProjectNameEvent(
                                            projectId: state.createdProject!.id,
                                            updatedProjectName:
                                                projectController.text,
                                            onSuccessCallback: (message) {
                                              ApiRepository().handleSuccessMessage(
                                                  "Project name updated successfully!......",
                                                  context);
                                            },
                                            warningMessageCallback:
                                                (String message,
                                                    int errorCode) {
                                              ApiRepository()
                                                  .handleWarningMessage(message,
                                                      context, errorCode);
                                            }));
                                  } else {
                                    context
                                        .read<ProjectArchitectBloc>()
                                        .add(CreateProjectEvent(
                                          clientId: state.selectedClient!.id,
                                          projectName: projectController.text,
                                          onSuccessCallback: (message) {
                                            setState(() {
                                              isProjectCreated = true;
                                            });
                                            ApiRepository().handleSuccessMessage(
                                                "Project created successfully!......",
                                                context);
                                          },
                                          onErrorCallback:
                                              (message, errorCode) {
                                            ApiRepository()
                                                .handleWarningMessage(message,
                                                    context, errorCode);
                                          },
                                        ));
                                  }
                                },
                          child: Text(
                              " ${isProjectCreated ? "Update Project" : "Create Project"} "),
                        )
                      ],
                    ),
                    // Text("${state.columnsList}")
                  ],
                ),
                Text(
                  "Columns to choose",
                  style: ClanChurnTypography.font18600,
                ),
                // ClanChurnSpacing.h10,
                Expanded(
                  child: AbsorbPointer(
                    absorbing: projectName.isEmpty,
                    child: Opacity(
                      // opacity: (projectName.isEmpty) ? 0.4 : 1.0,
                      opacity:
                          (projectName.isEmpty || state.createdProject == null)
                              ? 0.4
                              : (state.createdProject!.id.isEmpty)
                                  ? 0.4
                                  : 1.0,
                      child: ColumnDetailsWidget(
                          columnsList: state.columnsList,
                          customerColumnNames: state.customerColumnNames),
                      // child: SingleChildScrollView(
                      //   child: Wrap(
                      //     spacing: 0, // Horizontal spacing
                      //     runSpacing: 0, // Vertical spacing
                      //     children:
                      //         List.generate(state.columnsList.length, (index) {
                      //       return Row(
                      //         children: [
                      //           Checkbox(
                      //             value:
                      //                 state.columnsList[index].isUserCheckedIn,
                      //             onChanged: state
                      //                     .columnsList[index].isMandatory
                      //                 ? null
                      //                 : (value) {
                      //                     ColumnDetails a = state
                      //                         .columnsList[index]
                      //                         .copyWith(isUserCheckedIn: value);
                      //                     List<ColumnDetails> b =
                      //                         state.columnsList.toList();
                      //                     b[index] = a;
                      //                     context.read<ProjectArchitectBloc>().add(
                      //                         ReplaceColumnsEvent(
                      //                             columns: b, index: index));
                      //                   },
                      //           ),
                      //           Expanded(
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   state.columnsList[index].columnName,
                      //                   overflow: TextOverflow.visible,
                      //                 ),
                      //                 SizedBox(
                      //                     height: 30,
                      //                     width: 300,
                      //                     child: TextFormField(
                      //                       controller: state
                      //                           .customerColumnNames[index],
                      //                       cursorHeight: 15,
                      //                       onChanged: (value) {
                      //                         // Create a copy of the list of controllers
                      //                         List<TextEditingController>
                      //                             controllers = List.from(state
                      //                                 .customerColumnNames);

                      //                         // Update the text of the controller at the specified index
                      //                         controllers[index].text = value;

                      //                         // Get the current cursor position
                      //                         int cursorPosition = value.length;

                      //                         // Update the selection of the controller at the specified index
                      //                         controllers[index].selection =
                      //                             TextSelection.collapsed(
                      //                                 offset: cursorPosition
                      //                                 //   TextSelection.fromPosition(
                      //                                 // TextPosition(
                      //                                 //     offset: cursorPosition),
                      //                                 );

                      //                         // Dispatch an event to update the state with the modified list of controllers
                      //                         context.read<ProjectArchitectBloc>().add(
                      //                               CustomerColumnNamesEvent(
                      //                                   customerColumnNames:
                      //                                       controllers),
                      //                             );
                      //                       },
                      //                       decoration: const InputDecoration(
                      //                           contentPadding: EdgeInsets.only(
                      //                               left: 10, right: 10),
                      //                           border: OutlineInputBorder()),
                      //                     ))
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     }),
                      //   ),
                      // ),
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
                                      // for (var i in state.customerColumnNames) {
                                      //   print("${i.text}");
                                      // }

                                      context
                                          .read<ProjectArchitectBloc>()
                                          .add(AddColumnsToProjectEvent());
                                      GetDialog.showDownloadDialog(context);
                                    },
                      child: const Text("Next"),
                    ),
                  ],
                )
              ]),
        );
      },
    );
  }
}

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
  //  Navigator.push(
  //                         context,
  //                         customPageRouteForNavigation(
  //                             const HomePage()));
  // ignore: use_build_context_synchronously
  GoRouter.of(context).go(AppRoutes.home);
}

//  Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

class ColumnDetailsWidget extends StatelessWidget {
  final List<ColumnDetails> columnsList;
  final List<TextEditingController> customerColumnNames;

  const ColumnDetailsWidget({
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
                            Text(
                              column.columnName,
                              overflow: TextOverflow.visible,
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
                                      globalIndex+1,
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
