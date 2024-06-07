import 'dart:convert';

List<ProjectHistoryModel> projectHistoryModelFromJson(String str) => List<ProjectHistoryModel>.from(json.decode(str).map((x) => ProjectHistoryModel.fromJson(x)));

String projectHistoryModelToJson(List<ProjectHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectHistoryModel {
    String id;
    DateTime inputSheetUplodedTime;
    InputStatus inputStatus;
    CreatedBy? createdBy;

    ProjectHistoryModel({
        required this.id,
        required this.inputSheetUplodedTime,
        required this.inputStatus,
        required this.createdBy,
    });

    factory ProjectHistoryModel.fromJson(Map<String, dynamic> json) => ProjectHistoryModel(
        id: json["id"],
        inputSheetUplodedTime: DateTime.parse(json["input_sheet_uploded_time"]),
        inputStatus: inputStatusValues.map[json["input_status"]]!,
        createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "input_sheet_uploded_time": inputSheetUplodedTime.toIso8601String(),
        "input_status": inputStatusValues.reverse[inputStatus],
        "created_by": createdBy?.toJson(),
    };
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
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userId: json["user_id"],
        userType: json["user_type"],
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

enum InputStatus {
    UPLODED_DATA_UNSUCESSFULL
}

final inputStatusValues = EnumValues({
    "uploded_data_unsucessfull": InputStatus.UPLODED_DATA_UNSUCESSFULL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
