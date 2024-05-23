import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/utils/input_field_strings.dart';
import 'package:clan_churn/utils/spacing.dart';
import 'package:clan_churn/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

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
  // final List<TextEditingController> c =
  //     List.generate(34, (_) => TextEditingController());

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
    // for (var i in c) {
    //   i.clear();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// sign up Form
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.customerName,
                            controller: customerNameController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                            textInputFormatterType: TextInputFormatterType.string,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.projectName,
                            controller: projectNameController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.projectStartDate,
                            controller: projectStartDateController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.studyPeriodBeginningDate,
                            controller: studyPeriodBeginningDateController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.studyPeriodEndDate,
                            controller: studyPeriodEndDateController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels
                                .endDateForDateOfJoiningRelevantForStudy,
                            controller:
                                endDateForDateOfJoiningReleventForTheStudyController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                              textInputFormatterType: TextInputFormatterType.string,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            label: InputFieldLabels.unitForValuePerformance,
                            controller: unitForValuePerformanceController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label: InputFieldLabels.unitForQuantityPerformance,
                            controller: unitForQuantityPerformanceController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            label:
                                InputFieldLabels.projectMaximumResidencyMonth,
                            controller: projectMaximumResidencyMonthController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                          CustomTextFormField(
                            label:
                                InputFieldLabels.projectMaximumMonthlyIncentive,
                            controller:
                                projectMaximumMonthlyIncentiveController,
                            textInputType: TextInputType.name,
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
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
                            hintText: "hint text",
                            prefixIcon: Icons.person,
                            isObscureText: false,
                            isEnabled: true,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ProjectDetails a = ProjectDetails(
                                  departments: [],
                                  projectStartDate:
                                      projectStartDateController.text,
                                  studyPeriodBeginingDate:
                                      studyPeriodBeginningDateController.text,
                                  studyPeriodEndDate:
                                      studyPeriodEndDateController.text,
                                  earliestDateForDateOfJoiningReleventForTheStudy:
                                      earliestDateForDateOfJoiningReleventForTheStudyController
                                          .text,
                                  endDateForDateOfJoiningReleventForTheStudy:
                                      endDateForDateOfJoiningReleventForTheStudyController
                                          .text,
                                  designations: [],
                                  unitForValuePerformance:
                                      unitForValuePerformanceController.text,
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
                              print(a);
                              print(a.toJson());
                            },
                            child: Text("Next"),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

 

// Define the input formatters
List<TextInputFormatter> a = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
];

List<TextInputFormatter> b = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
];

List<TextInputFormatter> c = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),  // Allowing both digits and letters
];

// Define the enum
enum TextInputFormatterType { string, digitsOnly }

// Function to get the appropriate input formatter list
List<TextInputFormatter> getTextInputFormatterType(TextInputFormatterType textInputFormatterType) {
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
                  // border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: TextField(
                keyboardType: textInputType,
                cursorColor: Colors.grey,
                cursorHeight: 17,
                cursorWidth: 2.5,
                controller: controller,
                obscureText: isObscureText!,
                enabled: isEnabled,
                textInputAction: textInputAction,
                inputFormatters: getTextInputFormatterType(textInputFormatterType?? TextInputFormatterType.digitsOnly),
                decoration: InputDecoration(
                  hintText: label,
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
