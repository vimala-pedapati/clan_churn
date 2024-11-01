import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/cus_text_form_filed_for_input_form.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:clan_churn/components/pro_threshold_component.dart';
import 'package:clan_churn/components/upload_new_data.dart';
import 'package:clan_churn/components/uploaded_excel_summary_report.dart';
import 'package:clan_churn/utils/extensions.dart';
import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/lense_calendar.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetInputFields extends StatefulWidget {
  const GetInputFields({Key? key, this.isCreatingNewProject = false, this.onTap}) : super(key: key);
  final bool isCreatingNewProject;
  final Function()? onTap;
  @override
  State<GetInputFields> createState() => _GetInputFieldsState();
}

class _GetInputFieldsState extends State<GetInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> designations = [];
  List<TextEditingController> departments = [];
  TextEditingController customerNameController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectOwnerController = TextEditingController();
  TextEditingController projectStartDateController = TextEditingController();
  TextEditingController stuPerBegDateController = TextEditingController();
  TextEditingController stuPerEndDateController = TextEditingController();
  TextEditingController earDateForDOJController = TextEditingController();
  TextEditingController endDateForDOJController = TextEditingController();
  TextEditingController unitForValPerController = TextEditingController();
  TextEditingController unitForQuaPerforController = TextEditingController();
  List<CustomTextFormField> departmentFields = [];
  List<CustomTextFormField> designationFields = [];
  final PageController _pageController = PageController();
  String? errorText;
  int _currentPage = 0;
  void goToNextPage() {
    if (_currentPage < 3) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
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
    context.read<ProjectArchitectBloc>().add(const UploadNewSheetRequestedEvent(uploadNewSheetRequested: false));
    if (context.read<ProjectArchitectBloc>().state.selectedClient != null) {
      setState(() {
        customerNameController.text = context.read<ProjectArchitectBloc>().state.selectedClient!.name;
      });
    }
    Project? p = context.read<ProjectArchitectBloc>().state.createdProject;
    if (p != null) {
      setState(() {
        projectNameController.text = p.name ?? '';
        ProjectDetails? pd = context.read<ProjectArchitectBloc>().state.createdProject!.projectDetails;
        if (pd != null) {
          projectStartDateController.text = pd.projectStartDate?.split("T").first ?? "";
          stuPerBegDateController.text = pd.studyPeriodBeginingDate?.split("T").first ?? "";
          projectOwnerController.text = pd.projectOwner ?? "";
          stuPerEndDateController.text = pd.studyPeriodEndDate?.split("T").first ?? "";

          earDateForDOJController.text = pd.earDateForDOJRel?.split("T").first ?? "";

          endDateForDOJController.text = pd.endDateForDOJ?.split("T").first ?? "";

          unitForValPerController.text = pd.unitForValPer ?? "";

          unitForQuaPerforController.text = pd.unitForQuaPerfor ?? "";

          departments = [];
          designations = [];
          departmentFields = [];
          designationFields = [];
          if (pd.departments == null) {
            departments.add(TextEditingController());
            departmentFields.add(CustomTextFormField(
              label: "Department Covered in the Study",
              controller: departments[0],
              textInputType: TextInputType.name,
              isObscureText: false,
              isEnabled: true,
              textInputAction: TextInputAction.next,
              textInputFormatterType: TextInputFormatterType.string,
            ));
          } else {
            for (int i = 0; i < pd.departments!.length; i++) {
              departments.add(TextEditingController(text: pd.departments![i]));
            }
            for (int i = 0; i < pd.departments!.length; i++) {
              departmentFields.add(CustomTextFormField(label: "Department Covered in the Study", controller: departments[i], textInputType: TextInputType.name, isObscureText: false, isEnabled: true, textInputAction: TextInputAction.next, textInputFormatterType: TextInputFormatterType.string, isMandatory: i == 0 ? true : false));
            }
          }

          if (pd.designations == null) {
            designations.add(TextEditingController());
            designationFields.add(CustomTextFormField(
              label: "Designation Covered in the Study",
              controller: designations[0],
              textInputType: TextInputType.name,
              isObscureText: false,
              isEnabled: true,
              textInputAction: TextInputAction.next,
              textInputFormatterType: TextInputFormatterType.string,
            ));
          } else {
            for (int i = 0; i < pd.designations!.length; i++) {
              designations.add(TextEditingController(text: pd.designations![i]));
            }
            for (int i = 0; i < pd.designations!.length; i++) {
              designationFields.add(CustomTextFormField(label: "Designation Covered in the Study", controller: designations[i], textInputType: TextInputType.name, isObscureText: false, isEnabled: true, textInputAction: TextInputAction.next, textInputFormatterType: TextInputFormatterType.string, isMandatory: i == 0 ? true : false));
            }
          }
        } else {
          setState(() {
            projectStartDateController.text = DateTime.now().toString().split(" ").first;
          });
          departments.add(TextEditingController());
          departmentFields.add(CustomTextFormField(
            label: "Department Covered in the Study",
            controller: departments[0],
            textInputType: TextInputType.name,
            isObscureText: false,
            isEnabled: true,
            textInputAction: TextInputAction.next,
            textInputFormatterType: TextInputFormatterType.string,
          ));
          designations.add(TextEditingController());
          designationFields.add(CustomTextFormField(
            label: "Designation Covered in the Study",
            controller: designations[0],
            textInputType: TextInputType.name,
            isObscureText: false,
            isEnabled: true,
            textInputAction: TextInputAction.next,
            textInputFormatterType: TextInputFormatterType.string,
          ));
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    projectNameController.dispose();
    projectOwnerController.dispose();
    projectStartDateController.dispose();
    stuPerBegDateController.dispose();
    stuPerEndDateController.dispose();
    earDateForDOJController.dispose();
    endDateForDOJController.dispose();
    unitForValPerController.dispose();
    unitForQuaPerforController.dispose();
    for (var i in designations) {
      i.dispose();
    }
    for (var i in departments) {
      i.dispose();
    }
    super.dispose();
  }

  void setEarliestDOJ() {
    if (stuPerBegDateController.text.isNotEmpty && stuPerEndDateController.text.isNotEmpty) {
      setState(() {
        earDateForDOJController.text = calculateEarliestDOJ(stuPerBegDateController.text.toDateTime(), stuPerEndDateController.text.toDateTime()).toString().split(" ").first;
      });
    }
  }

  bool checkValidations() {
    if (projectOwnerController.text.trim().length < 2) {
      errorText = "Minimum Character Limit not met, please contact Admin";
      return false;
    }
    errorText = null;
    List<TextEditingController> controllers = [
      projectStartDateController,
      stuPerBegDateController,
      stuPerEndDateController,
      earDateForDOJController,
      endDateForDOJController,
      // unitForValuePerformanceController,
      // unitForQuantityPerformanceController,
      if (departments.isNotEmpty) departments[0],
      if (designations.isNotEmpty) designations[0],
    ];

    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }

    return true;
  }

  DateTime calculateEarliestDOJ(DateTime startDate, DateTime endDate) {
    int durationInMonths = ((endDate.year - startDate.year) * 12) + endDate.month - startDate.month + 1;
    DateTime earliestJoiningDate = DateTime(endDate.year, endDate.month - (2 * durationInMonths), endDate.day);

    return earliestJoiningDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        checkValidations();
        return Column(
          children: [
            if (!(widget.isCreatingNewProject) && _currentPage == 0) const ProInitialHeader(),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      runAlignment: WrapAlignment.end,
                                      // alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        if (!widget.isCreatingNewProject)
                                          CustomTextFormField(
                                            label: InputFieldLabels.customerName,
                                            controller: customerNameController,
                                            textInputType: TextInputType.name,
                                            isObscureText: false,
                                            isEnabled: true,
                                            textInputAction: TextInputAction.next,
                                            textInputFormatterType: TextInputFormatterType.string,
                                            readOnly: true,
                                          ),
                                        if (!widget.isCreatingNewProject)
                                          CustomTextFormField(
                                            label: InputFieldLabels.projectName,
                                            controller: projectNameController,
                                            textInputType: TextInputType.name,
                                            isObscureText: false,
                                            isEnabled: true,
                                            textInputAction: TextInputAction.next,
                                            textInputFormatterType: TextInputFormatterType.string,
                                            readOnly: true,
                                          ),
                                        // if (!widget.isCreatingNewProject)
                                        CustomTextFormField(
                                          label: InputFieldLabels.projectOwner,
                                          controller: projectOwnerController,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.projectStartDate,
                                          controller: projectStartDateController,
                                          hintText: 'Select Date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.calendar_month, size: 18),
                                            onPressed: () async {
                                              setState(() async {
                                                projectStartDateController.text = await GetCalendar().selectDate(context);
                                              });
                                            },
                                          ),
                                          readOnly: true,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.studyPeriodBeginningDate,
                                          controller: stuPerBegDateController,
                                          textInputType: TextInputType.name,
                                          hintText: 'Select Date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                              Icons.calendar_month,
                                              size: 18,
                                            ),
                                            onPressed: () async {
                                              setState(() async {
                                                stuPerBegDateController.text = await GetCalendar().selectDate(context);
                                                setEarliestDOJ();
                                              });
                                            },
                                          ),
                                          readOnly: true,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.studyPeriodEndDate,
                                          controller: stuPerEndDateController,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          hintText: 'Select Date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.calendar_month, size: 18),
                                            onPressed: () async {
                                              setState(() async {
                                                stuPerEndDateController.text = await GetCalendar().selectDate(context);
                                                endDateForDOJController.text = stuPerEndDateController.text;
                                                setEarliestDOJ();
                                              });
                                            },
                                          ),
                                          readOnly: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.earliestDateForDateOfJoiningRelevantForStudy,
                                          controller: earDateForDOJController,
                                          textInputType: TextInputType.name,
                                          hintText: 'Select Date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.calendar_month, size: 18),
                                            onPressed: () async {
                                              setState(() async {
                                                earDateForDOJController.text = await GetCalendar().selectDate(context);
                                              });
                                            },
                                          ),
                                          readOnly: true,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.endDateForDateOfJoiningRelevantForStudy,
                                          controller: endDateForDOJController,
                                          hintText: 'Select Date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.calendar_month, size: 18),
                                            onPressed: () async {
                                              setState(() async {
                                                endDateForDOJController.text = await GetCalendar().selectDate(context);
                                              });
                                            },
                                          ),
                                          readOnly: true,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.unitForValuePerformance,
                                          controller: unitForValPerController,
                                          isMandatory: false,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                        CustomTextFormField(
                                          label: InputFieldLabels.unitForQuantityPerformance,
                                          isMandatory: false,
                                          controller: unitForQuaPerforController,
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType: TextInputFormatterType.string,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: [
                                              ...departmentFields,
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          child: const Text("Add Department"),
                                          onPressed: () {
                                            setState(() {
                                              departments.add(TextEditingController());
                                              departmentFields.add(CustomTextFormField(
                                                label: "Department",
                                                controller: departments[departments.length - 1],
                                                textInputType: TextInputType.name,
                                                isObscureText: false,
                                                isEnabled: true,
                                                textInputAction: TextInputAction.next,
                                                textInputFormatterType: TextInputFormatterType.string,
                                                isMandatory: false,
                                              ));
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: [
                                              ...designationFields,
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              designations.add(TextEditingController());
                                              designationFields.add(CustomTextFormField(
                                                label: "Designation",
                                                controller: designations[designations.length - 1],
                                                textInputType: TextInputType.name,
                                                isObscureText: false,
                                                isEnabled: true,
                                                textInputAction: TextInputAction.next,
                                                textInputFormatterType: TextInputFormatterType.string,
                                                isMandatory: false,
                                              ));
                                            });
                                          },
                                          child: const Text("Add Designation"),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      ClanChurnSpacing.h10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (!checkValidations()) {
                                ApiRepository().handleWarningMessage(errorText ?? "Please fill in all the required fields before proceeding.", context);
                                return;
                              }
                              List<String> depart = [];
                              List<String> design = [];
                              for (var i in departments) {
                                depart.add(i.text);
                              }
                              for (var i in designations) {
                                design.add(i.text);
                              }
                              ProjectDetails a = ProjectDetails(
                                  departments: depart,
                                  designations: design,
                                  projectStartDate: projectStartDateController.text,
                                  projectOwner: projectOwnerController.text,
                                  studyPeriodBeginingDate: stuPerBegDateController.text,
                                  studyPeriodEndDate: stuPerEndDateController.text,
                                  earDateForDOJRel: earDateForDOJController.text,
                                  endDateForDOJ: endDateForDOJController.text,
                                  unitForValPer: unitForValPerController.text,
                                  unitForQuaPerfor: unitForQuaPerforController.text,
                                  thresholdVals: null);
                              // updating project details api
                              context.read<ProjectArchitectBloc>().add(UpdateProjectDetailsEvent(
                                    projectId: context.read<ProjectArchitectBloc>().state.createdProject!.id,
                                    projectDetails: a,
                                    onErrorCallback: (errorMessage, errorCode) {},
                                    onSuccessCallback: (message) {
                                      context.read<ProjectArchitectBloc>().add(GetProjectsListEvent(clientId: context.read<ProjectArchitectBloc>().state.selectedClient!.id));
                                      context.read<ProjectArchitectBloc>().add(GetColumnsEvent(context.read<ProjectArchitectBloc>().state.createdProject?.id));
                                    },
                                  ));
                              if (widget.isCreatingNewProject) {
                                widget.onTap!();
                              } else {
                                goToNextPage();
                              }

                              // }
                            },
                            child: const Text("Next"),
                          )
                        ],
                      ),
                    ],
                  ),
                  ProjectThresholdComponent(
                    onBackTap: () {
                      goToPreviousPage();
                    },
                    onNextTap: () {
                      goToNextPage();
                    },
                  ),
                  (state.createdProject!.latestInput == null || state.uploadNewSheetRequested)
                      ? UploadNewData(
                          onPressed: () {
                            goToPreviousPage();
                          },
                        )
                      : UploadedExcelSummaryReport(
                          onPressed: () {
                            goToPreviousPage();
                          },
                          uploadNewSheetRequested: () {
                            context.read<ProjectArchitectBloc>().add(const UploadNewSheetRequestedEvent(uploadNewSheetRequested: true));
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

class ProInitialHeader extends StatelessWidget {
  const ProInitialHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        return Row(
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
              "Project Initialization",
              style: ClanChurnTypography.font18600,
            ),
            Expanded(
              child: Container(),
            ),
            ElevatedButton(
              child: const Text(
                "download input sheet",
              ),
              onPressed: () {
                launchURL(state.createdProject!.inputSheet ?? "");
              },
            )
          ],
        );
      },
    );
  }
}
