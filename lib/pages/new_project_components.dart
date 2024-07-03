import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
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
            return const WrapProfile(
              child: Column(children: [
                // Nav bar
                NavBar(),
                SizedBox(height: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideBar(
                        selectedRoute: SelectedRoute.home,
                      ),
                      Expanded(child: AddNewProjectComponent())
                    ],
                  ),
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
        return ChurnContainer(
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
                SingleChildScrollView(
                  child: Column(
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
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 20),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 20),
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
                                                color: Colors.grey
                                                    .withOpacity(0.7)),
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
                                              projectId:
                                                  state.createdProject!.id,
                                              updatedProjectName:
                                                  projectController.text,
                                              onSuccessCallback: (message) {
                                                ApiRepository()
                                                    .handleSuccessMessage(
                                                        "Project name updated successfully!......",
                                                        context);
                                              },
                                              warningMessageCallback:
                                                  (String message,
                                                      int errorCode) {
                                                ApiRepository()
                                                    .handleWarningMessage(
                                                        message,
                                                        context,
                                                        errorCode);
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
  GoRouter.of(context).go(AppRoutes.home);
}
 
