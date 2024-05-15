import 'dart:convert';

import 'package:equatable/equatable.dart';

List<ProjectDetails> projectDetailsFromJson(String str) =>
    List<ProjectDetails>.from(
        json.decode(str).map((x) => ProjectDetails.fromJson(x)));

// String projectDetailsToJson(List<ProjectDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectDetails extends Equatable {
  final String id;
  final String name;
  final List<InputColumn>? inputColumns;
  final String? projectStatus;

  const ProjectDetails({
    required this.id,
    required this.name,
    required this.inputColumns,
    required this.projectStatus,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"],
        name: json["name"],
        inputColumns: json["input_columns"] == null
            ? null
            : List<InputColumn>.from(
                json["input_columns"].map((x) => InputColumn.fromJson(x))),
        projectStatus: json["project_status"],
      );

  @override
  List<Object?> get props => [name];

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "name": name,
  //     "input_columns": List<dynamic>.from(inputColumns.map((x) => x.toJson())),
  //     "project_status": projectStatus,
  // };
}

class InputColumn {
  String id;
  String sheetName;
  String columnName;
  bool isMandatory;

  InputColumn({
    required this.id,
    required this.sheetName,
    required this.columnName,
    required this.isMandatory,
  });

  factory InputColumn.fromJson(Map<String, dynamic> json) => InputColumn(
        id: json["id"],
        sheetName: json["sheet_name"],
        columnName: json["column_name"],
        isMandatory: json["is_mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetName,
        "column_name": columnName,
        "is_mandatory": isMandatory,
      };
}
