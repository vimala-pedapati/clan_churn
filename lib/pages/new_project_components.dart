import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/churn_continer.dart';
import 'package:clan_churn/components/cus_text.dart';
import 'package:clan_churn/components/input_fields.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/components/nav_bar.dart';
import 'package:clan_churn/components/side_bar.dart';
import 'package:clan_churn/components/wrap_profile.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewProject extends StatefulWidget {
  final String? projectId;
  final String clientId;
  const CreateNewProject({super.key, required this.projectId, required this.clientId});

  @override
  State<CreateNewProject> createState() => _CreateNewProjectState();
}

class _CreateNewProjectState extends State<CreateNewProject> {
  @override
  void initState() {
    if (widget.projectId != null) {
       context.read<ProjectArchitectBloc>().add(GetClientDetailsEvent(
            clientId: widget.clientId,
            onErrorCallback: (a, b) {},
            onSuccessCallback: (response) {},
          ));
      context.read<ProjectArchitectBloc>().add(ClearCreateProjectEvent());
      context.read<ProjectArchitectBloc>().add(GetProjectDetailsEvent(projectId: widget.projectId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return WrapProfile(
              child: Column(children: [
                // Nav bar
                const NavBar(),
                const SizedBox(height: 10),

                BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
                  builder: (context, state) {
                    return Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SideBar(
                            selectedRoute: SelectedRoute.home,
                          ),
                          if (!state.projectDetailsLoading) const Expanded(child: AddNewProjectComponent())
                        ],
                      ),
                    );
                  },
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
  int _currentPage = 0;
  final PageController _pageController = PageController();

  void _goToNextPage() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    setState(() {
      clientController.text = context.read<ProjectArchitectBloc>().state.selectedClient?.name ?? "";
    });

    if (context.read<ProjectArchitectBloc>().state.createdProject != null) {
      if (context.read<ProjectArchitectBloc>().state.createdProject!.id.isNotEmpty) {
        isProjectCreated = true;
      }
      setState(() {
        projectController.text = context.read<ProjectArchitectBloc>().state.createdProject!.name ?? '';
        projectName = context.read<ProjectArchitectBloc>().state.createdProject!.name ?? '';
        previousName = context.read<ProjectArchitectBloc>().state.createdProject!.name ?? '';
      });
    }
    context.read<ProjectArchitectBloc>().add(GetColumnsEvent(context.read<ProjectArchitectBloc>().state.createdProject?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return ChurnContainer(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
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
                        isProjectCreated ? "Update Project" : "Start New Project",
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
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Customer Name",
                                  //       style: ClanChurnTypography.font15900,
                                  //     ),
                                  //     Text(
                                  //       "*",
                                  //       style: ClanChurnTypography.font10600
                                  //           .copyWith(color: Colors.red),
                                  //     )
                                  //   ],
                                  // ),
                                  CusText(
                                    text: "Customer Name",
                                    textStyle: ClanChurnTypography.font15600,
                                  ),
                                  Container(
                                    width: 300,
                                    height: 30,
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                                    child: TextFormField(
                                      controller: clientController,
                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      cursorHeight: 15,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Client ID',
                                        hintStyle: ClanChurnTypography.font12500.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                        contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
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
                                  CusText(
                                    text: "Project Name",
                                    textStyle: ClanChurnTypography.font15600,
                                  ),
                                  Container(
                                    width: 300,
                                    height: 30,
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8.0)),
                                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                                    child: TextFormField(
                                      controller: projectController,
                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      cursorHeight: 15,
                                      readOnly: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
                                        LengthLimitingTextInputFormatter(100),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'Enter Project Name',
                                        hintStyle: ClanChurnTypography.font15400.copyWith(color: Colors.grey.withOpacity(0.7)),
                                        contentPadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
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
                            onPressed: (projectName.trim().isEmpty || projectName.trim().length < 2 || projectName == previousName)
                                ? null
                                : () {
                                    if (isProjectCreated) {
                                      context.read<ProjectArchitectBloc>().add(UpdateProjectNameEvent(
                                          projectId: state.createdProject!.id,
                                          updatedProjectName: projectController.text,
                                          onSuccessCallback: (message) {
                                            ApiRepository().handleSuccessMessage("Project name updated successfully!......", context);
                                          },
                                          warningMessageCallback: (String message, int errorCode) {
                                            ApiRepository().handleWarningMessage(
                                              message,
                                              context,
                                            );
                                          }));
                                    } else {
                                      context.read<ProjectArchitectBloc>().add(CreateProjectEvent(
                                            clientId: state.selectedClient!.id,
                                            projectName: projectController.text,
                                            projectId: state.createdProject?.id,
                                            onSuccessCallback: (message) {
                                              setState(() {
                                                isProjectCreated = true;
                                              });
                                              ApiRepository().handleSuccessMessage("Project created successfully!......", context);

                                              context.read<ProjectArchitectBloc>().add(GetProjectsListEvent(clientId: state.selectedClient!.id));
                                            },
                                            onErrorCallback: (message, errorCode) {
                                              ApiRepository().handleWarningMessage(
                                                message,
                                                context,
                                              );
                                            },
                                          ));
                                    }
                                  },
                            child: Text(" ${isProjectCreated ? "Update Project" : "Create Project"} "),
                          )
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: (projectName.isEmpty || state.createdProject == null || state.createdProject!.id.isEmpty),
                      child: Opacity(
                        opacity: (projectName.isEmpty || state.createdProject == null)
                            ? 0.4
                            : (state.createdProject!.id.isEmpty)
                                ? 0.4
                                : 1.0,
                        child: GetInputFields(
                            isCreatingNewProject: true,
                            onTap: () {
                              _goToNextPage();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              ColumnsToChooseWidget(
                projectName: projectName,
                onBackPressed: () {
                  _goToPreviousPage();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
