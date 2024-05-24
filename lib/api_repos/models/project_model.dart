import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Project> projectFromJson(String str) =>
    List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String projectToJson(Project data) => json.encode(data.toJson());

class Project extends Equatable {
  final String id;
  final String? name;
  final List<InputColumn>? inputColumns;
  final String? projectStatus;
  final String? inputSheet;
  final ProjectDetails? projectDetails;
  final List<String>? allInputs;
  final String? latestInput;

  const Project({
    required this.id,
    required this.name,
    required this.inputColumns,
    required this.projectStatus,
    required this.inputSheet,
    required this.projectDetails,
    required this.allInputs,
    required this.latestInput
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        inputColumns: json["input_columns"] == null
            ? null
            : List<InputColumn>.from(
                json["input_columns"].map((x) => InputColumn.fromJson(x))),
        projectStatus: json["project_status"],
        inputSheet: json["input_sheet"],
        projectDetails: json["project_details"] == null
            ? null
            : ProjectDetails.fromJson(json["project_details"]),
        allInputs: json["all_inputs"] == null
            ? null
            : List<String>.from(json["all_inputs"].map((x) => x)),
        latestInput:  json["latest_input"] 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "input_columns":
            List<dynamic>.from((inputColumns ?? []).map((x) => x.toJson())),
        "project_status": projectStatus,
        "input_sheet": inputSheet,
        "project_details":
            projectDetails == null ? null : projectDetails!.toJson(),
        "all_inputs": List<dynamic>.from((allInputs ?? []).map((x) => x)),
        "latest_input": latestInput
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, inputColumns, projectStatus, projectDetails, allInputs, latestInput];
}

class InputColumn extends Equatable {
  final String id;
  final String? sheetName;
  final String? columnName;
  final bool? isMandatory;
  final String? clientColumnName;

  const InputColumn({
    required this.id,
    required this.sheetName,
    required this.columnName,
    required this.isMandatory,
    required this.clientColumnName,
  });

  factory InputColumn.fromJson(Map<String, dynamic> json) => InputColumn(
        id: json["id"],
        sheetName: json["sheet_name"],
        columnName: json["column_name"],
        isMandatory: json["is_mandatory"],
        clientColumnName: json["client_column_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetName,
        "column_name": columnName,
        "is_mandatory": isMandatory,
        "client_column_name": clientColumnName,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, sheetName, columnName, isMandatory, clientColumnName];
}

class ProjectDetails extends Equatable {
  final String? projectStartDate;
  final String? studyPeriodBeginingDate;
  final String? studyPeriodEndDate;
  final String? earliestDateForDateOfJoiningReleventForTheStudy;
  final String? endDateForDateOfJoiningReleventForTheStudy;
  final List<String>? designations;
  final List<String>? departments;
  final String? unitForValuePerformance;
  final String? unitForQuantityPerformance;
  final int? projectMaximumResidencyMonth;
  final int? projectTopOutlierRankForResidencyMonthOfPerformanceMonth;
  final int? projectBottomOutlierRankForResidencyMonthOfPerformanceMonth;
  final int? projectMaxPerformanceValueTarget;
  final int? projectTopOutlierRankForMaximumPerformanceValueTarget;
  final int? projectBottomOutlierRankForMaximumPerformanceValueTarget;
  final int? projectMaximumPerformanceValueActual;
  final int? projectTopOutlierRankForMaximumPerformanceValueActual;
  final int? projectBottomOutlierRankForMaximumPerformanceValueActual;
  final int? projectMaximumPerformanceQuantityTarget;
  final int? projectTopOutlierRankForMaximumPerformanceQuantityTarget;
  final int? projectBottomOutlierRankForMaximumPerformanceQuantityTarget;
  final int? projectMaximumOverAllPerformanceAchievementPer;
  final int? projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer;
  final int? projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer;
  final int? projectMaximumMonthlyFixedSalaryIndex;
  final int? projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex;
  final int? projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex;
  final int? projectMaximumMonthlyIncentive;
  final int? projectTopOutlierRankForMaximumMonthlyIncentive;
  final int? projectBottomOutlierRankForMaximumMonthlyIncentive;

  const ProjectDetails({
    required this.projectStartDate,
    required this.studyPeriodBeginingDate,
    required this.studyPeriodEndDate,
    required this.earliestDateForDateOfJoiningReleventForTheStudy,
    required this.endDateForDateOfJoiningReleventForTheStudy,
    required this.designations,
    required this.departments,
    required this.unitForValuePerformance,
    required this.unitForQuantityPerformance,
    required this.projectMaximumResidencyMonth,
    required this.projectTopOutlierRankForResidencyMonthOfPerformanceMonth,
    required this.projectBottomOutlierRankForResidencyMonthOfPerformanceMonth,
    required this.projectMaxPerformanceValueTarget,
    required this.projectTopOutlierRankForMaximumPerformanceValueTarget,
    required this.projectBottomOutlierRankForMaximumPerformanceValueTarget,
    required this.projectMaximumPerformanceValueActual,
    required this.projectTopOutlierRankForMaximumPerformanceValueActual,
    required this.projectBottomOutlierRankForMaximumPerformanceValueActual,
    required this.projectMaximumPerformanceQuantityTarget,
    required this.projectTopOutlierRankForMaximumPerformanceQuantityTarget,
    required this.projectBottomOutlierRankForMaximumPerformanceQuantityTarget,
    required this.projectMaximumOverAllPerformanceAchievementPer,
    required this.projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer,
    required this.projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer,
    required this.projectMaximumMonthlyFixedSalaryIndex,
    required this.projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
    required this.projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex,
    required this.projectMaximumMonthlyIncentive,
    required this.projectTopOutlierRankForMaximumMonthlyIncentive,
    required this.projectBottomOutlierRankForMaximumMonthlyIncentive,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        projectStartDate: json["project_start_date"],
        studyPeriodBeginingDate: json["study_period_begining_date"],
        studyPeriodEndDate: json["study_period_end_date"],
        earliestDateForDateOfJoiningReleventForTheStudy:
            json["earliest_date_for_date_of_joining_relevent_for_the_study"],
        endDateForDateOfJoiningReleventForTheStudy:
            json["end_date_for_date_of_joining_relevent_for_the_study"],
        designations: List<String>.from(json["designations"].map((x) => x)),
        departments: List<String>.from(json["departments"].map((x) => x)),
        unitForValuePerformance: json["unit_for_value_performance"],
        unitForQuantityPerformance: json["unit_for_quantity_performance"],
        projectMaximumResidencyMonth: json["project_maximum_residency_month"],
        projectTopOutlierRankForResidencyMonthOfPerformanceMonth: json[
            "project_top_outlier_rank_for_residency_month_of_performance_month"],
        projectBottomOutlierRankForResidencyMonthOfPerformanceMonth: json[
            "project_bottom_outlier_rank_for_residency_month_of_performance_month"],
        projectMaxPerformanceValueTarget:
            json["project_max_performance_value_target"],
        projectTopOutlierRankForMaximumPerformanceValueTarget: json[
            "project_top_outlier_rank_for_maximum_performance_value_target"],
        projectBottomOutlierRankForMaximumPerformanceValueTarget: json[
            "project_bottom_outlier_rank_for_maximum_performance_value_target"],
        projectMaximumPerformanceValueActual:
            json["project_maximum_performance_value_actual"],
        projectTopOutlierRankForMaximumPerformanceValueActual: json[
            "project_top_outlier_rank_for_maximum_performance_value_actual"],
        projectBottomOutlierRankForMaximumPerformanceValueActual: json[
            "project_bottom_outlier_rank_for_maximum_performance_value_actual"],
        projectMaximumPerformanceQuantityTarget:
            json["project_maximum_performance_quantity_target"],
        projectTopOutlierRankForMaximumPerformanceQuantityTarget: json[
            "project_top_outlier_rank_for_maximum_performance_quantity_target"],
        projectBottomOutlierRankForMaximumPerformanceQuantityTarget: json[
            "project_bottom_outlier_rank_for_maximum_performance_quantity_target"],
        projectMaximumOverAllPerformanceAchievementPer:
            json["project_maximum_over_all_performance_achievement_per"],
        projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer: json[
            "project_top_outlier_rank_for_maximum_over_all_performance_achievement_per"],
        projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer: json[
            "project_bottom_outlier_rank_for_maximum_over_all_performance_achievement_per"],
        projectMaximumMonthlyFixedSalaryIndex:
            json["project_maximum_monthly_fixed_salary_index"],
        projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex: json[
            "project_top_outlier_rank_for_maximum_monthly_fixed_salary_index"],
        projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex: json[
            "project_bottom_outlier_rank_for_maximum_monthly_fixed_salary_index"],
        projectMaximumMonthlyIncentive:
            json["project_maximum_monthly_incentive"],
        projectTopOutlierRankForMaximumMonthlyIncentive:
            json["project_top_outlier_rank_for_maximum_monthly_incentive"],
        projectBottomOutlierRankForMaximumMonthlyIncentive:
            json["project_bottom_outlier_rank_for_maximum_monthly_incentive"],
      );

  Map<String, dynamic> toJson() => {
        "project_start_date": projectStartDate == null
            ? projectStartDate
            : projectStartDate!.isEmpty
                ? null
                : projectStartDate,
        "study_period_begining_date": studyPeriodBeginingDate == null
            ? studyPeriodBeginingDate
            : studyPeriodBeginingDate!.isEmpty
                ? null
                : studyPeriodBeginingDate,
        "study_period_end_date": studyPeriodEndDate == null
            ? studyPeriodEndDate
            : studyPeriodEndDate!.isEmpty
                ? null
                : studyPeriodEndDate,
        "earliest_date_for_date_of_joining_relevent_for_the_study":
            earliestDateForDateOfJoiningReleventForTheStudy == null
                ? earliestDateForDateOfJoiningReleventForTheStudy
                : earliestDateForDateOfJoiningReleventForTheStudy!.isEmpty
                    ? null
                    : earliestDateForDateOfJoiningReleventForTheStudy,
        "end_date_for_date_of_joining_relevent_for_the_study":
            endDateForDateOfJoiningReleventForTheStudy == null
                ? endDateForDateOfJoiningReleventForTheStudy
                : endDateForDateOfJoiningReleventForTheStudy!.isEmpty
                    ? null
                    : endDateForDateOfJoiningReleventForTheStudy,
        "designations": List<dynamic>.from((designations ?? []).map((x) => x)),
        "departments": List<dynamic>.from((departments ?? []).map((x) => x)),
        "unit_for_value_performance": unitForValuePerformance,
        "unit_for_quantity_performance": unitForQuantityPerformance,
        "project_maximum_residency_month": projectMaximumResidencyMonth,
        "project_top_outlier_rank_for_residency_month_of_performance_month":
            projectTopOutlierRankForResidencyMonthOfPerformanceMonth,
        "project_bottom_outlier_rank_for_residency_month_of_performance_month":
            projectBottomOutlierRankForResidencyMonthOfPerformanceMonth,
        "project_max_performance_value_target":
            projectMaxPerformanceValueTarget,
        "project_top_outlier_rank_for_maximum_performance_value_target":
            projectTopOutlierRankForMaximumPerformanceValueTarget,
        "project_bottom_outlier_rank_for_maximum_performance_value_target":
            projectBottomOutlierRankForMaximumPerformanceValueTarget,
        "project_maximum_performance_value_actual":
            projectMaximumPerformanceValueActual,
        "project_top_outlier_rank_for_maximum_performance_value_actual":
            projectTopOutlierRankForMaximumPerformanceValueActual,
        "project_bottom_outlier_rank_for_maximum_performance_value_actual":
            projectBottomOutlierRankForMaximumPerformanceValueActual,
        "project_maximum_performance_quantity_target":
            projectMaximumPerformanceQuantityTarget,
        "project_top_outlier_rank_for_maximum_performance_quantity_target":
            projectTopOutlierRankForMaximumPerformanceQuantityTarget,
        "project_bottom_outlier_rank_for_maximum_performance_quantity_target":
            projectBottomOutlierRankForMaximumPerformanceQuantityTarget,
        "project_maximum_over_all_performance_achievement_per":
            projectMaximumOverAllPerformanceAchievementPer,
        "project_top_outlier_rank_for_maximum_over_all_performance_achievement_per":
            projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer,
        "project_bottom_outlier_rank_for_maximum_over_all_performance_achievement_per":
            projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer,
        "project_maximum_monthly_fixed_salary_index":
            projectMaximumMonthlyFixedSalaryIndex,
        "project_top_outlier_rank_for_maximum_monthly_fixed_salary_index":
            projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
        "project_bottom_outlier_rank_for_maximum_monthly_fixed_salary_index":
            projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex,
        "project_maximum_monthly_incentive": projectMaximumMonthlyIncentive,
        "project_top_outlier_rank_for_maximum_monthly_incentive":
            projectTopOutlierRankForMaximumMonthlyIncentive,
        "project_bottom_outlier_rank_for_maximum_monthly_incentive":
            projectBottomOutlierRankForMaximumMonthlyIncentive,
      };

  @override
  List<Object?> get props => [
        projectStartDate,
        studyPeriodBeginingDate,
        studyPeriodEndDate,
        earliestDateForDateOfJoiningReleventForTheStudy,
        endDateForDateOfJoiningReleventForTheStudy,
        designations,
        departments,
        unitForValuePerformance,
        unitForQuantityPerformance,
        projectMaximumResidencyMonth,
        projectTopOutlierRankForResidencyMonthOfPerformanceMonth,
        projectBottomOutlierRankForResidencyMonthOfPerformanceMonth,
        projectMaxPerformanceValueTarget,
        projectTopOutlierRankForMaximumPerformanceValueTarget,
        projectBottomOutlierRankForMaximumPerformanceValueTarget,
        projectMaximumPerformanceValueActual,
        projectTopOutlierRankForMaximumPerformanceValueActual,
        projectBottomOutlierRankForMaximumPerformanceValueActual,
        projectMaximumPerformanceQuantityTarget,
        projectTopOutlierRankForMaximumPerformanceQuantityTarget,
        projectBottomOutlierRankForMaximumPerformanceQuantityTarget,
        projectMaximumOverAllPerformanceAchievementPer,
        projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer,
        projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer,
        projectMaximumMonthlyFixedSalaryIndex,
        projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
        projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex,
        projectMaximumMonthlyIncentive,
        projectTopOutlierRankForMaximumMonthlyIncentive,
        projectBottomOutlierRankForMaximumMonthlyIncentive,
      ];
}
