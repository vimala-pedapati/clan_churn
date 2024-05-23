import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/pages/project_input_fields_sheet.dart';
import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectInitialization extends StatefulWidget {
  const ProjectInitialization({super.key});

  @override
  State<ProjectInitialization> createState() => _ProjectInitializationState();
}

class _ProjectInitializationState extends State<ProjectInitialization> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  void _goToNextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Page 1',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Container(
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Page 2',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Page 3',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _goToPreviousPage,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _goToNextPage,
            ),
          ],
        ),
      ],
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Text(
        label,
        style: ClanChurnTypography.font15600,
      ),
    );
  }
}

class GetInputFields extends StatefulWidget {
  const GetInputFields({Key? key}) : super(key: key);

  @override
  State<GetInputFields> createState() => _GetInputFieldsState();
}

class _GetInputFieldsState extends State<GetInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> designations = [TextEditingController()];
  List<TextEditingController> departments = [TextEditingController()];
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
  TextEditingController endDateForDateOfJoiningReleventForTheStudyController =
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
    setState(() {
      departmentFields.add(CustomTextFormField(
        label: "department1 covered in the study",
        controller: departments[0],
        textInputType: TextInputType.name,
        isObscureText: false,
        isEnabled: true,
        textInputAction: TextInputAction.next,
        textInputFormatterType: TextInputFormatterType.string,
      ));
      designationFields.add(CustomTextFormField(
        label: "designation1 covered in the study",
        controller: designations[0],
        textInputType: TextInputType.name,
        isObscureText: false,
        isEnabled: true,
        textInputAction: TextInputAction.next,
        textInputFormatterType: TextInputFormatterType.string,
      ));
    });

    if (context.read<UserBloc>().state.selectedClient != null) {
      setState(() {
        customerNameController.text =
            context.read<UserBloc>().state.selectedClient!.name;
      });
    }
    Project? p = context.read<UserBloc>().state.createdProject;
    if (p != null) {
      setState(() {
        projectNameController.text = p.name ?? '';
        ProjectDetails? pd =
            context.read<UserBloc>().state.createdProject!.projectDetails;
        if (pd != null) {
          projectStartDateController.text = pd.projectStartDate ?? "";
          studyPeriodBeginningDateController.text =
              pd.studyPeriodBeginingDate ?? "";

          studyPeriodEndDateController.text = pd.studyPeriodEndDate ?? "";

          earliestDateForDateOfJoiningReleventForTheStudyController.text =
              pd.earliestDateForDateOfJoiningReleventForTheStudy ?? "";

          endDateForDateOfJoiningReleventForTheStudyController.text =
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
    endDateForDateOfJoiningReleventForTheStudyController.dispose();
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
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked.toString();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
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
                    "Project Initialization",
                    style: ClanChurnTypography.font18600,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Select Initialization",
                    style: ClanChurnTypography.font14500,
                  ),
                  ClanChurnSpacing.w15,
                  // DropDown
                  const GetInitializationDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ClanChurnSpacing.h10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                    icon: const Icon(Icons.calendar_month),
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
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label:
                                      InputFieldLabels.studyPeriodBeginningDate,
                                  controller:
                                      studyPeriodBeginningDateController,
                                  textInputType: TextInputType.name,
                                  hintText: 'Select Date',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () async {
                                      setState(() async {
                                        studyPeriodBeginningDateController
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
                                  label: InputFieldLabels.studyPeriodEndDate,
                                  controller: studyPeriodEndDateController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  hintText: 'Select Date',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () async {
                                      setState(() async {
                                        studyPeriodEndDateController.text =
                                            await selectDate(context);
                                      });
                                    },
                                  ),
                                  readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  textInputFormatterType:
                                      TextInputFormatterType.string,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .earliestDateForDateOfJoiningRelevantForStudy,
                                  controller:
                                      earliestDateForDateOfJoiningReleventForTheStudyController,
                                  textInputType: TextInputType.name,
                                  hintText: 'Select Date',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_month),
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
                                      endDateForDateOfJoiningReleventForTheStudyController,
                                  hintText: 'Select Date',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () async {
                                      setState(() async {
                                        endDateForDateOfJoiningReleventForTheStudyController
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
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label:
                                      InputFieldLabels.unitForValuePerformance,
                                  controller: unitForValuePerformanceController,
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
                                  controller:
                                      unitForQuantityPerformanceController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                  textInputFormatterType:
                                      TextInputFormatterType.string,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumResidencyMonth,
                                  controller:
                                      projectMaximumResidencyMonthController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForResidencyMonthofPerformanceMonth,
                                  controller:
                                      projectTopOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankForResidencyMonthOfPerformaceMonth,
                                  controller:
                                      projectBottomOutlierRankForResidencyMonthOfPerformanceMonthController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumPerformanceValueTarget,
                                  controller:
                                      projectMaxPerformanceValueTargetController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumPerforamceValueTarget,
                                  controller:
                                      projectTopOutlierRankForMaximumPerformanceValueTargetController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumPerformanceValueTarget,
                                  controller:
                                      projectBottomOutlierRankForMaximumPerformanceValueTargetController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumPerformanceValueActual,
                                  controller:
                                      projectMaximumPerformanceValueActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumPerformanceValueActual,
                                  controller:
                                      projectTopOutlierRankForMaximumPerformanceValueActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumPerformacealueActual,
                                  controller:
                                      projectBottomOutlierRankForMaximumPerformanceValueActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumPerformanceQuantityActual,
                                  controller:
                                      projectMaximumPerformanceQuantityActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumPerformanceQuantityTarget,
                                  controller:
                                      projectTopOutlierRankForMaximumPerformanceQuantityTargetController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumPerformanceQuatityTarget,
                                  controller:
                                      projectBottomOutlierRankForMaximumPerformanceQuantityTargetController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumPerformanceQuantityActual,
                                  controller:
                                      projectMaximumPerformanceQuantityActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumPerformanceQuantityActual,
                                  controller:
                                      projectTopOutlierRankForMaximumPerformanceQuantityActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumPerformanceQuantityActual,
                                  controller:
                                      projectBottomOutlierRankMaximumPerformanceQuantityActualController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumOverAllPerformancePerAchievement,
                                  controller:
                                      projectMaximumOverAllPerformanceAchievementPerController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumOverAllPerformanceAchieventPer,
                                  controller:
                                      projectTopOutlierRankForMaximumOverAllPerformanceAchievementPerController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumOverAllPerformanceAchievementPer,
                                  controller:
                                      projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPerController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumMonthlyFixedSalaryIndex,
                                  controller:
                                      projectMaximumMonthlyFixedSalaryIndexController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
                                  controller:
                                      projectTopOutlierRankForMaximumMonthlyFixedSalaryIndexController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumMonthlyFixedSalaryIndex,
                                  controller:
                                      projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndexController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectMaximumMonthlyIncentive,
                                  controller:
                                      projectMaximumMonthlyIncentiveController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectTopOutlierRankForMaximumMonthlyIncentive,
                                  controller:
                                      projectTopOutlierRankForMaximumMonthlyIncentiveController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                                CustomTextFormField(
                                  label: InputFieldLabels
                                      .projectBottomOutlierRankMaximumMonthlyIncentive,
                                  controller:
                                      projectBottomOutlierRankForMaximumMonthlyIncentiveController,
                                  textInputType: TextInputType.name,
                                  isObscureText: false,
                                  isEnabled: true,
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...departmentFields,
                                    TextButton(
                                      child: const Text("add department"),
                                      onPressed: () {
                                        setState(() {
                                          departments
                                              .add(TextEditingController());
                                          departmentFields
                                              .add(CustomTextFormField(
                                            label:
                                                "department${departmentFields.length + 1}",
                                            controller: departments[
                                                departments.length - 1],
                                            textInputType: TextInputType.name,
                                            isObscureText: false,
                                            isEnabled: true,
                                            textInputAction:
                                                TextInputAction.next,
                                            textInputFormatterType:
                                                TextInputFormatterType.string,
                                          ));
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...designationFields,
                                    TextButton(
                                      child: const Text("add designation"),
                                      onPressed: () {
                                        setState(() {
                                          designations
                                              .add(TextEditingController());
                                          designationFields
                                              .add(CustomTextFormField(
                                            label:
                                                "designation ${designationFields.length + 1}",
                                            controller: designations[
                                                designations.length - 1],
                                            textInputType: TextInputType.name,
                                            isObscureText: false,
                                            isEnabled: true,
                                            textInputAction:
                                                TextInputAction.next,
                                            textInputFormatterType:
                                                TextInputFormatterType.string,
                                          ));
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                            ClanChurnSpacing.h10,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
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
                                        projectStartDate:
                                            projectStartDateController.text,
                                        studyPeriodBeginingDate:
                                            studyPeriodBeginningDateController
                                                .text,
                                        studyPeriodEndDate:
                                            studyPeriodEndDateController.text,
                                        earliestDateForDateOfJoiningReleventForTheStudy:
                                            earliestDateForDateOfJoiningReleventForTheStudyController
                                                .text,
                                        endDateForDateOfJoiningReleventForTheStudy:
                                            endDateForDateOfJoiningReleventForTheStudyController
                                                .text,
                                        designations: design,
                                        unitForValuePerformance:
                                            unitForValuePerformanceController
                                                .text,
                                        unitForQuantityPerformance: '',
                                        projectMaximumResidencyMonth: int.parse(
                                            projectMaximumResidencyMonthController
                                                    .text.isEmpty
                                                ? '0'
                                                : projectMaximumResidencyMonthController
                                                    .text),
                                        projectTopOutlierRankForResidencyMonthOfPerformanceMonth:
                                            int.parse(projectTopOutlierRankForResidencyMonthOfPerformanceMonthController.text.isEmpty ? '0' : projectTopOutlierRankForResidencyMonthOfPerformanceMonthController.text),
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
                                    context.read<UserBloc>().add(
                                        UpdateProjectDetailsEvent(
                                            projectId: context
                                                .read<UserBloc>()
                                                .state
                                                .createdProject!
                                                .id,
                                            projectDetails: a));
                                    print(a);
                                    print(a.toJson());

                                    // goToNextPage();
                                  },
                                  child: const Text("Next"),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          Container(
            child: Text("vimala"),
          )
        ],
      ),
    );
  }
}

// Define the input formatters
List<TextInputFormatter> a = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
];

List<TextInputFormatter> b = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
];

List<TextInputFormatter> c = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
      RegExp(r'[a-zA-Z0-9 ]')), // Allowing both digits and letters
];

// Define the enum
enum TextInputFormatterType { string, digitsOnly }

// Function to get the appropriate input formatter list
List<TextInputFormatter> getTextInputFormatterType(
    TextInputFormatterType textInputFormatterType) {
  switch (textInputFormatterType) {
    case TextInputFormatterType.string:
      return a;
    case TextInputFormatterType.digitsOnly:
      return b;
    default:
      return c;
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {this.controller,
      this.textInputType,
      this.hintText,
      this.prefixIcon,
      required this.isObscureText,
      required this.isEnabled,
      this.textInputAction,
      this.label,
      this.textInputFormatterType,
      this.readOnly = false,
      this.suffixIcon,
      Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? prefixIcon;
  final bool? isObscureText;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  final String? label;
  final TextInputFormatterType? textInputFormatterType;
  final bool readOnly;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    //     // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      // padding: const EdgeInsets.fromLTRB(10, 3, 20, 0),

      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabel(
            label: label ?? "",
          ),
          ClanChurnSpacing.h6,
          Container(
              width: w * 0.35,
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),

                  // border: Border.all(color: Colors.black),
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                keyboardType: textInputType,
                cursorColor: Colors.grey,
                cursorHeight: 17,
                cursorWidth: 2.5,
                controller: controller,
                obscureText: isObscureText!,
                enabled: isEnabled,
                readOnly: readOnly,
                textInputAction: textInputAction,
                inputFormatters: getTextInputFormatterType(
                    textInputFormatterType ??
                        TextInputFormatterType.digitsOnly),
                decoration: InputDecoration(
                  hintText: hintText ?? label,
                  suffixIcon: suffixIcon,
                  hintStyle: ClanChurnTypography.font14500
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                  contentPadding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              )),
        ],
      ),
    );
  }
}