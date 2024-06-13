import 'dart:convert';

import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:equatable/equatable.dart';

List<ProjectHistoryModel> projectHistoryModelFromJson(String str) =>
    List<ProjectHistoryModel>.from(
        json.decode(str).map((x) => ProjectHistoryModel.fromJson(x)));

String projectHistoryModelToJson(List<ProjectHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectHistoryModel extends Equatable {
  final String id;
  final DateTime? inputSheetUplodedTime;
  final InputStatus? inputStatus;
  final CreatedBy? createdBy;

  const ProjectHistoryModel({
    required this.id,
    required this.inputSheetUplodedTime,
    required this.inputStatus,
    required this.createdBy,
  });

  factory ProjectHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProjectHistoryModel(
      id: json["id"],
      inputSheetUplodedTime: json["input_sheet_uploded_time"] == null
          ? json["input_sheet_uploded_time"]
          : DateTime.parse(json["input_sheet_uploded_time"]),
      inputStatus: InputStatusExtension.fromString(json["input_status"]),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "input_sheet_uploded_time": inputSheetUplodedTime == null
            ? inputSheetUplodedTime
            : inputSheetUplodedTime!.toIso8601String(),
        "input_status": inputStatus,
        "created_by": createdBy?.toJson(),
      };

  @override
  List<Object?> get props =>
      [id, inputSheetUplodedTime, inputStatus, createdBy];
}

class CreatedBy {
  dynamic clientDetails;
  String firstName;
  String lastName;
  String email;
  String userId;
  String userType;

  CreatedBy({
    required this.clientDetails,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userId,
    required this.userType,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        clientDetails: json["client_details"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        userId: json["user_id"] ?? "",
        userType: json["user_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "client_details": clientDetails,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_id": userId,
        "user_type": userType,
      };
}
