import 'dart:convert';

import 'package:clan_churn/api_repos/models/threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
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
  final LatestInputModel? latestInputModel;

  const Project(
      {required this.id,
      required this.name,
      required this.inputColumns,
      required this.projectStatus,
      required this.inputSheet,
      required this.projectDetails,
      required this.allInputs,
      required this.latestInput,
      required this.latestInputModel});

  Project copyWith({
    String? id,
    String? name,
    List<InputColumn>? inputColumns,
    String? projectStatus,
    String? inputSheet,
    ProjectDetails? projectDetails,
    List<String>? allInputs,
    String? latestInput,
    LatestInputModel? latestInputModel,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      inputColumns: inputColumns ?? this.inputColumns,
      projectStatus: projectStatus ?? this.projectStatus,
      inputSheet: inputSheet ?? this.inputSheet,
      projectDetails: projectDetails ?? this.projectDetails,
      allInputs: allInputs ?? this.allInputs,
      latestInput: latestInput ?? this.latestInput,
      latestInputModel: latestInputModel ?? this.latestInputModel,
    );
  }

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
      latestInput: json["latest_input"],
      latestInputModel: json["latest_input_model"] == null
          ? null
          : LatestInputModel.fromJson(json["latest_input_model"]));

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
        "latest_input": latestInput,
        "latest_input_model": latestInputModel!.toJson()
      };

  @override
  List<Object?> get props => [
        id,
        name,
        inputColumns,
        projectStatus,
        projectDetails,
        allInputs,
        latestInput,
        latestInputModel
      ];
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
  List<Object?> get props =>
      [id, sheetName, columnName, isMandatory, clientColumnName];
}

class ProjectDetails extends Equatable {
  final String? projectStartDate;
  final String? studyPeriodBeginingDate;
  final String? studyPeriodEndDate;
  final String? projectOwner;
  final String? earDateForDOJRel;
  final String? endDateForDOJ;
  final List<String>? designations;
  final List<String>? departments;
  final String? unitForValPer;
  final String? unitForQuaPerfor;
  final List<ProThreModel>? thresholdVals;

  const ProjectDetails(
      {required this.projectStartDate,
      required this.studyPeriodBeginingDate,
      required this.studyPeriodEndDate,
      required this.projectOwner,
      required this.earDateForDOJRel,
      required this.endDateForDOJ,
      required this.designations,
      required this.departments,
      required this.unitForValPer,
      required this.unitForQuaPerfor,
      required this.thresholdVals});

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
      projectStartDate: json["project_start_date"],
      studyPeriodBeginingDate: json["study_period_begining_date"],
      studyPeriodEndDate: json["study_period_end_date"],
      projectOwner: json["project_owner"],
      earDateForDOJRel:
          json["earliest_date_for_date_of_joining_relevent_for_the_study"],
      endDateForDOJ:
          json["end_date_for_date_of_joining_relevent_for_the_study"],
      designations: List<String>.from(json["designations"].map((x) => x)),
      departments: List<String>.from(json["departments"].map((x) => x)),
      unitForValPer: json["unit_for_value_performance"],
      unitForQuaPerfor: json["unit_for_quantity_performance"],
      thresholdVals:
          List<ProThreModel>.from((json["threshold_details"] ?? []).map(
        (e) => ProThreModel.fromJson(e),
      )));

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
        "project_owner": projectOwner,
        "study_period_end_date": studyPeriodEndDate == null
            ? studyPeriodEndDate
            : studyPeriodEndDate!.isEmpty
                ? null
                : studyPeriodEndDate,
        "earliest_date_for_date_of_joining_relevent_for_the_study":
            earDateForDOJRel == null
                ? earDateForDOJRel
                : earDateForDOJRel!.isEmpty
                    ? null
                    : earDateForDOJRel,
        "end_date_for_date_of_joining_relevent_for_the_study":
            endDateForDOJ == null
                ? endDateForDOJ
                : endDateForDOJ!.isEmpty
                    ? null
                    : endDateForDOJ,
        "designations": List<dynamic>.from((designations ?? []).map((x) => x)),
        "departments": List<dynamic>.from((departments ?? []).map((x) => x)),
        "unit_for_value_performance": unitForValPer,
        "unit_for_quantity_performance": unitForQuaPerfor,
        "threshold_details":
            List<dynamic>.from((thresholdVals ?? []).map((e) => e.toJson()))
      };

  @override
  List<Object?> get props => [
        projectStartDate,
        studyPeriodBeginingDate,
        studyPeriodEndDate,
        projectOwner,
        earDateForDOJRel,
        endDateForDOJ,
        designations,
        departments,
        unitForValPer,
        unitForQuaPerfor,
        thresholdVals
      ];
}

LatestInputModel latestInputModelFromJson(String str) =>
    LatestInputModel.fromJson(json.decode(str));

String latestInputModelToJson(LatestInputModel data) =>
    json.encode(data.toJson());

class LatestInputModel extends Equatable {
  final String id;
  final String? inputSheetUplodedTime;
  final InputStatus? inputStatus;
  final String? errorSheetUrl;
  final String? martsSheetUrl;
  final User? createdBy;

  const LatestInputModel(
      {required this.id,
      required this.inputSheetUplodedTime,
      required this.inputStatus,
      required this.createdBy,
      required this.errorSheetUrl,
      required this.martsSheetUrl});

  factory LatestInputModel.fromJson(Map<String, dynamic> json) =>
      LatestInputModel(
        id: json["id"],
        inputSheetUplodedTime: json["input_sheet_uploded_time"],
        inputStatus: InputStatusExtension.fromString(json["input_status"]),
        errorSheetUrl: json["error_sheet_url"],
        martsSheetUrl: json["marts_sheet_url"],
        createdBy: json["created_by"] == null
            ? null
            : User.fromJson(json["created_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "input_sheet_uploded_time": inputSheetUplodedTime,
        "input_status": inputStatus?.value,
        "created_by": createdBy!.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        inputSheetUplodedTime,
        inputStatus,
        errorSheetUrl,
        martsSheetUrl,
        createdBy
      ];
}

enum InputStatus {
  unknown,
  uploadedDataSuccessful,
  uploadedDataUnsuccessful,
  uploadedDataHasErrors,
  uploadedDataHasNoErrors,
  uploadedDataDataMartsGenerated,
  uploadedDataDataMartsCannotBeGenerated,
}

extension InputStatusExtension on InputStatus {
  String get value {
    switch (this) {
      case InputStatus.uploadedDataSuccessful:
        return "uploded_data_successfull";
      case InputStatus.uploadedDataUnsuccessful:
        return "uploded_data_unsucessfull";
      case InputStatus.uploadedDataHasErrors:
        return "uploded_data_has_errors";
      case InputStatus.uploadedDataHasNoErrors:
        return "uploded_data_has_no_errors";
      case InputStatus.uploadedDataDataMartsGenerated:
        return "uploded_data_data_marts_generated";
      case InputStatus.uploadedDataDataMartsCannotBeGenerated:
        return "uploded_data_data_marts_connot_be_genrated";
      default:
        return "unknown";
    }
  }

  String get properValue {
    switch (this) {
      case InputStatus.uploadedDataSuccessful:
        return "uploded data successfull";
      case InputStatus.uploadedDataUnsuccessful:
        return "uploded data unsucessfull";
      case InputStatus.uploadedDataHasErrors:
        return "uploded data has errors";
      case InputStatus.uploadedDataHasNoErrors:
        return "uploded data has no errors";
      case InputStatus.uploadedDataDataMartsGenerated:
        return "uploded data data marts generated";
      case InputStatus.uploadedDataDataMartsCannotBeGenerated:
        return "uploded data data marts connot be genrated";
      default:
        return "unknown";
    }
  }

  static InputStatus fromString(String value) {
    switch (value) {
      case "uploded_data_successfull":
        return InputStatus.uploadedDataSuccessful;
      case "uploded_data_unsucessfull":
        return InputStatus.uploadedDataUnsuccessful;
      case "uploded_data_has_errors":
        return InputStatus.uploadedDataHasErrors;
      case "uploded_data_has_no_errors":
        return InputStatus.uploadedDataHasNoErrors;
      case "uploded_data_data_marts_generated":
        return InputStatus.uploadedDataDataMartsGenerated;
      case "uploded_data_data_marts_connot_be_genrated":
        return InputStatus.uploadedDataDataMartsCannotBeGenerated;
      default:
        throw InputStatus.unknown;
    }
  }
}
