import 'dart:convert';

List<GetProThresholdFormValModel> projectThresholdFormValueModelFromJson(
    String str) {
  List<dynamic> data = json.decode(str) as List<dynamic>;
  return List<GetProThresholdFormValModel>.from(data.map((x) {
    return GetProThresholdFormValModel.fromJson(x);
  }));
}

String projectThresholdFormValueModelToJson(
        List<GetProThresholdFormValModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProThresholdFormValModel {
  String id;
  String sheetName;
  String columnName;
  bool isMandatory;
  bool isEditable;
  String? depends;
  String clientColumnName;
  ColumnDataType columnDataType;

  GetProThresholdFormValModel({
    required this.id,
    required this.sheetName,
    required this.columnName,
    required this.isMandatory,
    required this.isEditable,
    required this.depends,
    required this.clientColumnName,
    required this.columnDataType,
  });

  factory GetProThresholdFormValModel.fromJson(Map<String, dynamic> json) =>
      GetProThresholdFormValModel(
        id: json["id"],
        sheetName: json["sheet_name"]!,
        columnName: json["column_name"],
        isMandatory: json["is_mandatory"],
        isEditable: json["is_editable"],
        depends: json["depends"],
        clientColumnName: json["client_column_name"],
        columnDataType: columnDataTypeValues.map[json["column_data_type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetName,
        "column_name": columnName,
        "is_mandatory": isMandatory,
        "is_editable": isEditable,
        "depends": depends,
        "client_column_name": clientColumnName,
        "column_data_type": columnDataTypeValues.reverse[columnDataType],
      };
}

enum ColumnDataType { date, numeric }

final columnDataTypeValues = EnumValues(
    {"date": ColumnDataType.date, "numeric": ColumnDataType.numeric});

enum SheetName {
  customerEmployeeBasicData,
  customerEmployeeWorkData,
  customerPerformanceData
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
