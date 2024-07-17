import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/components/cus_text_form_filed_for_input_form.dart';
import 'package:clan_churn/components/upload_new_data.dart';
import 'package:clan_churn/components/uploaded_excel_summary_report.dart';
import 'package:clan_churn/utils/extensions.dart';
import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetInputFields extends StatefulWidget {
  const GetInputFields(
      {Key? key, this.isCreatingNewProject = false, this.onTap})
      : super(key: key);
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
  TextEditingController studyPeriodBeginningDateController =
      TextEditingController();
  TextEditingController studyPeriodEndDateController = TextEditingController();
  TextEditingController
      earliestDateForDateOfJoiningReleventForTheStudyController =
      TextEditingController();
  TextEditingController endDateForDOJReleventForTheStudyController =
      TextEditingController();
  TextEditingController unitForValuePerformanceController =
      TextEditingController();
  TextEditingController unitForQuantityPerformanceController =
      TextEditingController();
  TextEditingController projectMaximumResidencyMonthController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForResidencyMonthOfPerformanceMonthController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController =
      TextEditingController();
  TextEditingController projectMaxPerformanceValueTargetController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumPerformanceValueTargetController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumPerformanceValueTargetController =
      TextEditingController();
  TextEditingController projectMaximumPerformanceValueActualController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumPerformanceValueActualController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumPerformanceValueActualController =
      TextEditingController();
  TextEditingController projectMaximumPerformanceQuantityActualController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumPerformanceQuantityActualController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankMaximumPerformanceQuantityActualController =
      TextEditingController();
  TextEditingController projectMaximumPerformanceQuantityTargetController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumPerformanceQuantityTargetController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumPerformanceQuantityTargetController =
      TextEditingController();
  TextEditingController
      projectMaximumOverAllPerformanceAchievementPerController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController =
      TextEditingController();
  TextEditingController projectMaximumMonthlyFixedSalaryIndexController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController =
      TextEditingController();
  TextEditingController projectMaximumMonthlyIncentiveController =
      TextEditingController();
  TextEditingController
      projectTopOutlierRankForMaximumMonthlyIncentiveController =
      TextEditingController();
  TextEditingController
      projectBottomOutlierRankForMaximumMonthlyIncentiveController =
      TextEditingController();

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
    context.read<ProjectArchitectBloc>().add(
        const UploadNewSheetRequestedEvent(uploadNewSheetRequested: false));
    if (context.read<ProjectArchitectBloc>().state.selectedClient != null) {
      setState(() {
        customerNameController.text =
            context.read<ProjectArchitectBloc>().state.selectedClient!.name;
      });
    }
    Project? p = context.read<ProjectArchitectBloc>().state.createdProject;
    if (p != null) {
      setState(() {
        projectNameController.text = p.name ?? '';
        ProjectDetails? pd = context
            .read<ProjectArchitectBloc>()
            .state
            .createdProject!
            .projectDetails;
        if (pd != null) {
          projectStartDateController.text =
              pd.projectStartDate?.split("T").first ?? "";
          studyPeriodBeginningDateController.text =
              pd.studyPeriodBeginingDate?.split("T").first ?? "";
          projectOwnerController.text = pd.projectOwner ?? "";
          studyPeriodEndDateController.text =
              pd.studyPeriodEndDate?.split("T").first ?? "";

          earliestDateForDateOfJoiningReleventForTheStudyController.text =
              pd.earliestDateForDateOfJoiningReleventForTheStudy ?? "";

          endDateForDOJReleventForTheStudyController.text =
              pd.endDateForDateOfJoiningReleventForTheStudy ?? "";

          unitForValuePerformanceController.text =
              pd.unitForValuePerformance ?? "";

          unitForQuantityPerformanceController.text =
              pd.unitForQuantityPerformance ?? "";

          projectMaximumResidencyMonthController.text =
              (pd.projectMaximumResidencyMonth ?? "").toString();

          projectTopOutlierRankForResidencyMonthOfPerformanceMonthController
                  .text =
              (pd.projectTopOutlierRankForResidencyMonthOfPerformanceMonth ??
                      "")
                  .toString();

          projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController
                  .text =
              (pd.projectBottomOutlierRankForResidencyMonthOfPerformanceMonth ??
                      "")
                  .toString();

          projectMaxPerformanceValueTargetController.text =
              (pd.projectMaxPerformanceValueTarget ?? "").toString();

          projectTopOutlierRankForMaximumPerformanceValueTargetController.text =
              (pd.projectTopOutlierRankForMaximumPerformanceValueTarget ?? "")
                  .toString();

          projectBottomOutlierRankForMaximumPerformanceValueTargetController
                  .text =
              (pd.projectBottomOutlierRankForMaximumPerformanceValueTarget ??
                      "")
                  .toString();

          projectMaximumPerformanceValueActualController.text =
              (pd.projectMaximumPerformanceValueActual ?? "").toString();

          projectTopOutlierRankForMaximumPerformanceValueActualController.text =
              (pd.projectTopOutlierRankForMaximumPerformanceValueActual ?? "")
                  .toString();

          projectBottomOutlierRankForMaximumPerformanceValueActualController
                  .text =
              (pd.projectBottomOutlierRankForMaximumPerformanceValueActual ??
                      "")
                  .toString();

          //  projectMaximumPerformanceQuantityActualController.text= (pd.projectMaximumPerformanceQuantityActual ?? "").toString();
          projectMaximumPerformanceQuantityActualController.text =
              ("").toString();

          // projectTopOutlierRankForMaximumPerformanceQuantityActualController.text= (pd.projectTopOutlierRankForMaximumPerformanceQuantityActual ?? "").toString();
          projectTopOutlierRankForMaximumPerformanceQuantityActualController
              .text = ("").toString();

          // projectBottomOutlierRankMaximumPerformanceQuantityActualController.text= (pd.projectBottomOutlierRankMaximumPerformanceQuantityActual ?? "").toString();
          projectBottomOutlierRankMaximumPerformanceQuantityActualController
              .text = ("").toString();

          projectMaximumPerformanceQuantityTargetController.text =
              (pd.projectMaximumPerformanceQuantityTarget ?? "").toString();

          projectTopOutlierRankForMaximumPerformanceQuantityTargetController
                  .text =
              (pd.projectTopOutlierRankForMaximumPerformanceQuantityTarget ??
                      "")
                  .toString();

          projectBottomOutlierRankForMaximumPerformanceQuantityTargetController
                  .text =
              (pd.projectBottomOutlierRankForMaximumPerformanceQuantityTarget ??
                      "")
                  .toString();

          projectMaximumOverAllPerformanceAchievementPerController.text =
              (pd.projectMaximumOverAllPerformanceAchievementPer ?? "")
                  .toString();

          projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController
                  .text =
              (pd.projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer ??
                      "")
                  .toString();

          projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController
                  .text =
              (pd.projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer ??
                      "")
                  .toString();

          projectMaximumMonthlyFixedSalaryIndexController.text =
              (pd.projectMaximumMonthlyFixedSalaryIndex ?? "").toString();

          projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController
                  .text =
              (pd.projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex ?? "")
                  .toString();

          projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController
                  .text =
              (pd.projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex ??
                      "")
                  .toString();

          projectMaximumMonthlyIncentiveController.text =
              (pd.projectMaximumMonthlyIncentive ?? "").toString();

          projectTopOutlierRankForMaximumMonthlyIncentiveController.text =
              (pd.projectTopOutlierRankForMaximumMonthlyIncentive ?? "")
                  .toString();

          projectBottomOutlierRankForMaximumMonthlyIncentiveController.text =
              (pd.projectBottomOutlierRankForMaximumMonthlyIncentive ?? "")
                  .toString();

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
              departmentFields.add(CustomTextFormField(
                  label: "Department Covered in the Study",
                  controller: departments[i],
                  textInputType: TextInputType.name,
                  isObscureText: false,
                  isEnabled: true,
                  textInputAction: TextInputAction.next,
                  textInputFormatterType: TextInputFormatterType.string,
                  isMandatory: i == 0 ? true : false));
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
              designations
                  .add(TextEditingController(text: pd.designations![i]));
            }
            for (int i = 0; i < pd.designations!.length; i++) {
              designationFields.add(CustomTextFormField(
                  label: "Designation Covered in the Study",
                  controller: designations[i],
                  textInputType: TextInputType.name,
                  isObscureText: false,
                  isEnabled: true,
                  textInputAction: TextInputAction.next,
                  textInputFormatterType: TextInputFormatterType.string,
                  isMandatory: i == 0 ? true : false));
            }
          }
        } else {
          setState(() {
            projectStartDateController.text =
                DateTime.now().toString().split(" ").first;
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
    studyPeriodBeginningDateController.dispose();
    studyPeriodEndDateController.dispose();
    earliestDateForDateOfJoiningReleventForTheStudyController.dispose();
    endDateForDOJReleventForTheStudyController.dispose();
    unitForValuePerformanceController.dispose();
    unitForQuantityPerformanceController.dispose();
    projectMaximumResidencyMonthController.dispose();
    projectTopOutlierRankForResidencyMonthOfPerformanceMonthController
        .dispose();
    projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController
        .dispose();
    projectMaxPerformanceValueTargetController.dispose();
    projectTopOutlierRankForMaximumPerformanceValueTargetController.dispose();
    projectBottomOutlierRankForMaximumPerformanceValueTargetController
        .dispose();
    projectMaximumPerformanceValueActualController.dispose();
    projectTopOutlierRankForMaximumPerformanceValueActualController.dispose();
    projectBottomOutlierRankForMaximumPerformanceValueActualController
        .dispose();
    projectMaximumPerformanceQuantityActualController.dispose();
    projectTopOutlierRankForMaximumPerformanceQuantityActualController
        .dispose();
    projectBottomOutlierRankMaximumPerformanceQuantityActualController
        .dispose();
    projectMaximumPerformanceQuantityTargetController.dispose();
    projectTopOutlierRankForMaximumPerformanceQuantityTargetController
        .dispose();
    projectBottomOutlierRankForMaximumPerformanceQuantityTargetController
        .dispose();
    projectMaximumOverAllPerformanceAchievementPerController.dispose();
    projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController
        .dispose();
    projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController
        .dispose();
    projectMaximumMonthlyFixedSalaryIndexController.dispose();
    projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController.dispose();
    projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController
        .dispose();
    projectMaximumMonthlyIncentiveController.dispose();
    projectTopOutlierRankForMaximumMonthlyIncentiveController.dispose();
    projectBottomOutlierRankForMaximumMonthlyIncentiveController.dispose();
    for (var i in designations) {
      i.dispose();
    }
    for (var i in departments) {
      i.dispose();
    }
    super.dispose();
  }

  Future<String> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      return picked.toString().split(" ").first;
    } else {
      return '';
    }
  }

  setEarliestDOJ() {
    if (studyPeriodBeginningDateController.text.isNotEmpty &&
        studyPeriodEndDateController.text.isNotEmpty) {
      setState(() {
        earliestDateForDateOfJoiningReleventForTheStudyController.text =
            calculateEarliestDOJ(
                    studyPeriodBeginningDateController.text.toDateTime(),
                    studyPeriodEndDateController.text.toDateTime())
                .toString()
                .split(" ")
                .first;
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
      studyPeriodBeginningDateController,
      studyPeriodEndDateController,
      earliestDateForDateOfJoiningReleventForTheStudyController,
      endDateForDOJReleventForTheStudyController,
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
    int durationInMonths = ((endDate.year - startDate.year) * 12) +
        endDate.month -
        startDate.month +
        1;
    DateTime earliestJoiningDate = DateTime(
        endDate.year, endDate.month - (2 * durationInMonths), endDate.day);

    return earliestJoiningDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectArchitectBloc, ProjectArchitectState>(
      builder: (context, state) {
        checkValidations();
        return PageView(
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
                                      textInputFormatterType:
                                          TextInputFormatterType.string,
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
                                      textInputFormatterType:
                                          TextInputFormatterType.string,
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
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels.projectStartDate,
                                    controller: projectStartDateController,
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_month,
                                          size: 18),
                                      onPressed: () async {
                                        setState(() async {
                                          projectStartDateController.text =
                                              await selectDate(context);
                                        });
                                      },
                                    ),
                                    readOnly: true,
                                    textInputType: TextInputType.name,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels
                                        .studyPeriodBeginningDate,
                                    controller:
                                        studyPeriodBeginningDateController,
                                    textInputType: TextInputType.name,
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.calendar_month,
                                        size: 18,
                                      ),
                                      onPressed: () async {
                                        setState(() async {
                                          studyPeriodBeginningDateController
                                              .text = await selectDate(context);
                                          setEarliestDOJ();
                                        });
                                      },
                                    ),
                                    readOnly: true,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels.studyPeriodEndDate,
                                    controller: studyPeriodEndDateController,
                                    textInputType: TextInputType.name,
                                    isObscureText: false,
                                    isEnabled: true,
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_month,
                                          size: 18),
                                      onPressed: () async {
                                        setState(() async {
                                          studyPeriodEndDateController.text =
                                              await selectDate(context);
                                          setEarliestDOJ();
                                        });
                                      },
                                    ),
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels
                                        .earliestDateForDateOfJoiningRelevantForStudy,
                                    controller:
                                        earliestDateForDateOfJoiningReleventForTheStudyController,
                                    textInputType: TextInputType.name,
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_month,
                                          size: 18),
                                      onPressed: () async {
                                        setState(() async {
                                          earliestDateForDateOfJoiningReleventForTheStudyController
                                              .text = await selectDate(context);
                                        });
                                      },
                                    ),
                                    readOnly: true,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels
                                        .endDateForDateOfJoiningRelevantForStudy,
                                    controller:
                                        endDateForDOJReleventForTheStudyController,
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_month,
                                          size: 18),
                                      onPressed: () async {
                                        setState(() async {
                                          endDateForDOJReleventForTheStudyController
                                              .text = await selectDate(context);
                                        });
                                      },
                                    ),
                                    readOnly: true,
                                    textInputType: TextInputType.name,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels
                                        .unitForValuePerformance,
                                    controller:
                                        unitForValuePerformanceController,
                                    isMandatory: false,
                                    textInputType: TextInputType.name,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  CustomTextFormField(
                                    label: InputFieldLabels
                                        .unitForQuantityPerformance,
                                    isMandatory: false,
                                    controller:
                                        unitForQuantityPerformanceController,
                                    textInputType: TextInputType.name,
                                    isObscureText: false,
                                    isEnabled: true,
                                    textInputAction: TextInputAction.next,
                                    textInputFormatterType:
                                        TextInputFormatterType.string,
                                  ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  //   controller:
                                  //       projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),

                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumResidencyMonth,
                                  //   controller:
                                  //       projectMaximumResidencyMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankForResidencyMonthOfPerformaceMonth,
                                  //   controller:
                                  //       projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumPerformanceValueTarget,
                                  //   controller:
                                  //       projectMaxPerformanceValueTargetController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumPerforamceValueTarget,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumPerformanceValueTargetController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumPerformanceValueTarget,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumPerformanceValueTargetController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumPerformanceValueActual,
                                  //   controller:
                                  //       projectMaximumPerformanceValueActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumPerformanceValueActual,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumPerformanceValueActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumPerformacealueActual,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumPerformanceValueActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumPerformanceQuantityActual,
                                  //   controller:
                                  //       projectMaximumPerformanceQuantityActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumPerformanceQuantityTarget,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumPerformanceQuantityTargetController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumPerformanceQuatityTarget,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumPerformanceQuantityTargetController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumPerformanceQuantityActual,
                                  //   controller:
                                  //       projectMaximumPerformanceQuantityActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumPerformanceQuantityActual,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumPerformanceQuantityActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumPerformanceQuantityActual,
                                  //   controller:
                                  //       projectBottomOutlierRankMaximumPerformanceQuantityActualController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumOverAllPerformancePerAchievement,
                                  //   controller:
                                  //       projectMaximumOverAllPerformanceAchievementPerController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumOverAllPerformanceAchieventPer,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumOverAllPerformanceAchievementPer,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumMonthlyFixedSalaryIndex,
                                  //   controller:
                                  //       projectMaximumMonthlyFixedSalaryIndexController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumMonthlyFixedSalaryIndex,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectTopOutlierRankForMaximumMonthlyIncentive,
                                  //   controller:
                                  //       projectTopOutlierRankForMaximumMonthlyIncentiveController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectBottomOutlierRankMaximumMonthlyIncentive,
                                  //   controller:
                                  //       projectBottomOutlierRankForMaximumMonthlyIncentiveController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  // CustomTextFormField(
                                  //   label: InputFieldLabels
                                  //       .projectMaximumMonthlyIncentive,
                                  //   controller:
                                  //       projectMaximumMonthlyIncentiveController,
                                  //   textInputType: TextInputType.name,
                                  //   isObscureText: false,
                                  //   isEnabled: true,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
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
                                        departments
                                            .add(TextEditingController());
                                        departmentFields
                                            .add(CustomTextFormField(
                                          label: "Department",
                                          controller: departments[
                                              departments.length - 1],
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType:
                                              TextInputFormatterType.string,
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
                                    // style: TextButton.styleFrom(
                                    //     padding: const EdgeInsets.all(0)),
                                    onPressed: () {
                                      setState(() {
                                        designations
                                            .add(TextEditingController());
                                        designationFields
                                            .add(CustomTextFormField(
                                          label: "Designation",
                                          controller: designations[
                                              designations.length - 1],
                                          textInputType: TextInputType.name,
                                          isObscureText: false,
                                          isEnabled: true,
                                          textInputAction: TextInputAction.next,
                                          textInputFormatterType:
                                              TextInputFormatterType.string,
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
                          ApiRepository().handleWarningMessage(
                              errorText ??
                                  "Please fill in all the required fields before proceeding.",
                              context);
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
                            studyPeriodBeginingDate:
                                studyPeriodBeginningDateController.text,
                            studyPeriodEndDate:
                                studyPeriodEndDateController.text,
                            earliestDateForDateOfJoiningReleventForTheStudy:
                                earliestDateForDateOfJoiningReleventForTheStudyController
                                    .text,
                            endDateForDateOfJoiningReleventForTheStudy:
                                endDateForDOJReleventForTheStudyController.text,
                            unitForValuePerformance:
                                unitForValuePerformanceController.text,
                            unitForQuantityPerformance:
                                unitForQuantityPerformanceController.text,
                            projectMaximumResidencyMonth: int.parse(projectMaximumResidencyMonthController.text.isEmpty
                                ? '0'
                                : projectMaximumResidencyMonthController.text),
                            projectTopOutlierRankForResidencyMonthOfPerformanceMonth:
                                int.parse(projectTopOutlierRankForResidencyMonthOfPerformanceMonthController
                                        .text.isEmpty
                                    ? '0'
                                    : projectTopOutlierRankForResidencyMonthOfPerformanceMonthController.text),
                            projectBottomOutlierRankForResidencyMonthOfPerformanceMonth: int.parse(projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController.text.isEmpty ? '0' : projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController.text),
                            projectMaxPerformanceValueTarget: int.parse(projectMaxPerformanceValueTargetController.text.isEmpty ? '0' : projectMaxPerformanceValueTargetController.text),
                            projectTopOutlierRankForMaximumPerformanceValueTarget: int.parse(projectTopOutlierRankForMaximumPerformanceValueTargetController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumPerformanceValueTargetController.text),
                            projectBottomOutlierRankForMaximumPerformanceValueTarget: int.parse(projectBottomOutlierRankForMaximumPerformanceValueTargetController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumPerformanceValueTargetController.text),
                            projectMaximumPerformanceValueActual: int.parse(projectMaximumPerformanceValueActualController.text.isEmpty ? '0' : projectMaximumPerformanceValueActualController.text),
                            projectTopOutlierRankForMaximumPerformanceValueActual: int.parse(projectTopOutlierRankForMaximumPerformanceValueActualController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumPerformanceValueActualController.text),
                            projectBottomOutlierRankForMaximumPerformanceValueActual: int.parse(projectBottomOutlierRankForMaximumPerformanceValueActualController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumPerformanceValueActualController.text),
                            projectMaximumPerformanceQuantityTarget: int.parse(projectMaximumPerformanceQuantityTargetController.text.isEmpty ? '0' : projectMaximumPerformanceQuantityTargetController.text),
                            projectTopOutlierRankForMaximumPerformanceQuantityTarget: int.parse(projectTopOutlierRankForMaximumPerformanceQuantityTargetController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumPerformanceQuantityTargetController.text),
                            projectBottomOutlierRankForMaximumPerformanceQuantityTarget: int.parse(projectBottomOutlierRankForMaximumPerformanceQuantityTargetController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumPerformanceQuantityTargetController.text),
                            projectMaximumOverAllPerformanceAchievementPer: int.parse(projectMaximumOverAllPerformanceAchievementPerController.text.isEmpty ? '0' : projectMaximumOverAllPerformanceAchievementPerController.text),
                            projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer: int.parse(projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController.text),
                            projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer: int.parse(projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController.text),
                            projectMaximumMonthlyFixedSalaryIndex: int.parse(projectMaximumMonthlyFixedSalaryIndexController.text.isEmpty ? '0' : projectMaximumMonthlyFixedSalaryIndexController.text),
                            projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex: int.parse(projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController.text),
                            projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex: int.parse(projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController.text),
                            projectMaximumMonthlyIncentive: int.parse(projectMaximumMonthlyIncentiveController.text.isEmpty ? '0' : projectMaximumMonthlyIncentiveController.text),
                            projectTopOutlierRankForMaximumMonthlyIncentive: int.parse(projectTopOutlierRankForMaximumMonthlyIncentiveController.text.isEmpty ? '0' : projectTopOutlierRankForMaximumMonthlyIncentiveController.text),
                            projectBottomOutlierRankForMaximumMonthlyIncentive: int.parse(projectBottomOutlierRankForMaximumMonthlyIncentiveController.text.isEmpty ? '0' : projectBottomOutlierRankForMaximumMonthlyIncentiveController.text));
                        // updating project details api
                        context.read<ProjectArchitectBloc>().add(
                            UpdateProjectDetailsEvent(
                                projectId: context
                                    .read<ProjectArchitectBloc>()
                                    .state
                                    .createdProject!
                                    .id,
                                projectDetails: a));
                        print("project details that are going to update: $a");
                        print(" ${widget.isCreatingNewProject}");
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
            (state.createdProject!.latestInput == null ||
                    state.uploadNewSheetRequested)
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
                      context.read<ProjectArchitectBloc>().add(
                          const UploadNewSheetRequestedEvent(
                              uploadNewSheetRequested: true));
                    },
                  )
          ],
        );
      },
    );
  }
}
