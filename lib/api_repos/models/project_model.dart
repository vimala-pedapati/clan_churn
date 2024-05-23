 

import 'dart:convert';

 
List<Project> projectFromJson(String str) =>
    List<Project>.from(
        json.decode(str).map((x) => Project.fromJson(x)));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
    String id;
    String? name;
    List<InputColumn>? inputColumns;
    String? projectStatus;
    String? inputSheet;
    ProjectDetails? projectDetails;
    List<String>? allInputs;

    Project({
        required this.id,
        required this.name,
        required this.inputColumns,
        required this.projectStatus,
        required this.inputSheet,
        required this.projectDetails,
        required this.allInputs,
    });

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"] ,
        inputColumns:  json["input_columns"] == null? null : List<InputColumn>.from(json["input_columns"].map((x) => InputColumn.fromJson(x))),
        projectStatus: json["project_status"],
        inputSheet: json["input_sheet"],
        projectDetails: json["project_details"] == null? null:  ProjectDetails.fromJson(json["project_details"]),
        allInputs: json["all_inputs"] == null ? null :  List<String>.from(json["all_inputs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "input_columns": List<dynamic>.from((inputColumns ?? []).map((x) => x.toJson())),
        "project_status": projectStatus,
        "input_sheet": inputSheet,
        "project_details": projectDetails == null? null:  projectDetails!.toJson(),
        "all_inputs": List<dynamic>.from((allInputs ?? []).map((x) => x)),
    };
}

class InputColumn {
    String id;
    String? sheetName;
    String? columnName;
    bool? isMandatory;
    String? clientColumnName;

    InputColumn({
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
}

class ProjectDetails {
    String? projectStartDate;
    String? studyPeriodBeginingDate;
    String? studyPeriodEndDate;
    String? earliestDateForDateOfJoiningReleventForTheStudy;
    String? endDateForDateOfJoiningReleventForTheStudy;
    List<String>? designations;
    List<String>? departments;
    String? unitForValuePerformance;
    String? unitForQuantityPerformance;
    int? projectMaximumResidencyMonth;
    int? projectTopOutlierRankForResidencyMonthOfPerformanceMonth;
    int? projectBottomOutlierRankForResidencyMonthOfPerformanceMonth;
    int? projectMaxPerformanceValueTarget;
    int? projectTopOutlierRankForMaximumPerformanceValueTarget;
    int? projectBottomOutlierRankForMaximumPerformanceValueTarget;
    int? projectMaximumPerformanceValueActual;
    int? projectTopOutlierRankForMaximumPerformanceValueActual;
    int? projectBottomOutlierRankForMaximumPerformanceValueActual;
    int? projectMaximumPerformanceQuantityTarget;
    int? projectTopOutlierRankForMaximumPerformanceQuantityTarget;
    int? projectBottomOutlierRankForMaximumPerformanceQuantityTarget;
    int? projectMaximumOverAllPerformanceAchievementPer;
    int? projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer;
    int? projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer;
    int? projectMaximumMonthlyFixedSalaryIndex;
    int? projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex;
    int? projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex;
    int? projectMaximumMonthlyIncentive;
    int? projectTopOutlierRankForMaximumMonthlyIncentive;
    int? projectBottomOutlierRankForMaximumMonthlyIncentive;

    ProjectDetails({
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
        projectStartDate:  json["project_start_date"],
        studyPeriodBeginingDate:  json["study_period_begining_date"],
        studyPeriodEndDate: json["study_period_end_date"],
        earliestDateForDateOfJoiningReleventForTheStudy:  json["earliest_date_for_date_of_joining_relevent_for_the_study"],
        endDateForDateOfJoiningReleventForTheStudy:  json["end_date_for_date_of_joining_relevent_for_the_study"],
        designations: List<String>.from(json["designations"].map((x) => x)),
        departments: List<String>.from(json["departments"].map((x) => x)),
        unitForValuePerformance: json["unit_for_value_performance"],
        unitForQuantityPerformance: json["unit_for_quantity_performance"],
        projectMaximumResidencyMonth: json["project_maximum_residency_month"],
        projectTopOutlierRankForResidencyMonthOfPerformanceMonth: json["project_top_outlier_rank_for_residency_month_of_performance_month"],
        projectBottomOutlierRankForResidencyMonthOfPerformanceMonth: json["project_bottom_outlier_rank_for_residency_month_of_performance_month"],
        projectMaxPerformanceValueTarget: json["project_max_performance_value_target"],
        projectTopOutlierRankForMaximumPerformanceValueTarget: json["project_top_outlier_rank_for_maximum_performance_value_target"],
        projectBottomOutlierRankForMaximumPerformanceValueTarget: json["project_bottom_outlier_rank_for_maximum_performance_value_target"],
        projectMaximumPerformanceValueActual: json["project_maximum_performance_value_actual"],
        projectTopOutlierRankForMaximumPerformanceValueActual: json["project_top_outlier_rank_for_maximum_performance_value_actual"],
        projectBottomOutlierRankForMaximumPerformanceValueActual: json["project_bottom_outlier_rank_for_maximum_performance_value_actual"],
        projectMaximumPerformanceQuantityTarget: json["project_maximum_performance_quantity_target"],
        projectTopOutlierRankForMaximumPerformanceQuantityTarget: json["project_top_outlier_rank_for_maximum_performance_quantity_target"],
        projectBottomOutlierRankForMaximumPerformanceQuantityTarget: json["project_bottom_outlier_rank_for_maximum_performance_quantity_target"],
        projectMaximumOverAllPerformanceAchievementPer: json["project_maximum_over_all_performance_achievement_per"],
        projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer: json["project_top_outlier_rank_for_maximum_over_all_performance_achievement_per"],
        projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer: json["project_bottom_outlier_rank_for_maximum_over_all_performance_achievement_per"],
        projectMaximumMonthlyFixedSalaryIndex: json["project_maximum_monthly_fixed_salary_index"],
        projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex: json["project_top_outlier_rank_for_maximum_monthly_fixed_salary_index"],
        projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex: json["project_bottom_outlier_rank_for_maximum_monthly_fixed_salary_index"],
        projectMaximumMonthlyIncentive: json["project_maximum_monthly_incentive"],
        projectTopOutlierRankForMaximumMonthlyIncentive: json["project_top_outlier_rank_for_maximum_monthly_incentive"],
        projectBottomOutlierRankForMaximumMonthlyIncentive: json["project_bottom_outlier_rank_for_maximum_monthly_incentive"],
    );

    Map<String, dynamic> toJson() => {
        "project_start_date":   projectStartDate,
        "study_period_begining_date": studyPeriodBeginingDate,
        "study_period_end_date": studyPeriodEndDate,
        "earliest_date_for_date_of_joining_relevent_for_the_study": earliestDateForDateOfJoiningReleventForTheStudy,
        "end_date_for_date_of_joining_relevent_for_the_study": endDateForDateOfJoiningReleventForTheStudy,
        "designations": List<dynamic>.from((designations ?? []).map((x) => x)),
        "departments": List<dynamic>.from((departments?? []).map((x) => x)),
        "unit_for_value_performance": unitForValuePerformance,
        "unit_for_quantity_performance": unitForQuantityPerformance,
        "project_maximum_residency_month": projectMaximumResidencyMonth,
        "project_top_outlier_rank_for_residency_month_of_performance_month": projectTopOutlierRankForResidencyMonthOfPerformanceMonth,
        "project_bottom_outlier_rank_for_residency_month_of_performance_month": projectBottomOutlierRankForResidencyMonthOfPerformanceMonth,
        "project_max_performance_value_target": projectMaxPerformanceValueTarget,
        "project_top_outlier_rank_for_maximum_performance_value_target": projectTopOutlierRankForMaximumPerformanceValueTarget,
        "project_bottom_outlier_rank_for_maximum_performance_value_target": projectBottomOutlierRankForMaximumPerformanceValueTarget,
        "project_maximum_performance_value_actual": projectMaximumPerformanceValueActual,
        "project_top_outlier_rank_for_maximum_performance_value_actual": projectTopOutlierRankForMaximumPerformanceValueActual,
        "project_bottom_outlier_rank_for_maximum_performance_value_actual": projectBottomOutlierRankForMaximumPerformanceValueActual,
        "project_maximum_performance_quantity_target": projectMaximumPerformanceQuantityTarget,
        "project_top_outlier_rank_for_maximum_performance_quantity_target": projectTopOutlierRankForMaximumPerformanceQuantityTarget,
        "project_bottom_outlier_rank_for_maximum_performance_quantity_target": projectBottomOutlierRankForMaximumPerformanceQuantityTarget,
        "project_maximum_over_all_performance_achievement_per": projectMaximumOverAllPerformanceAchievementPer,
        "project_top_outlier_rank_for_maximum_over_all_performance_achievement_per": projectTopOutlierRankForMaximumOverAllPerformanceAchievementPer,
        "project_bottom_outlier_rank_for_maximum_over_all_performance_achievement_per": projectBottomOutlierRankForMaximumOverAllPerformanceAchievementPer,
        "project_maximum_monthly_fixed_salary_index": projectMaximumMonthlyFixedSalaryIndex,
        "project_top_outlier_rank_for_maximum_monthly_fixed_salary_index": projectTopOutlierRankForMaximumMonthlyFixedSalaryIndex,
        "project_bottom_outlier_rank_for_maximum_monthly_fixed_salary_index": projectBottomOutlierRankForMaximumMonthlyFixedSalaryIndex,
        "project_maximum_monthly_incentive": projectMaximumMonthlyIncentive,
        "project_top_outlier_rank_for_maximum_monthly_incentive": projectTopOutlierRankForMaximumMonthlyIncentive,
        "project_bottom_outlier_rank_for_maximum_monthly_incentive": projectBottomOutlierRankForMaximumMonthlyIncentive,
    };
}
