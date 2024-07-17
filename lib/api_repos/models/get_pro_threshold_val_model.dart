import 'dart:convert';

List<GetProThresholdValModel> projectThresholdValueModelFromJson(
        String str) =>
    List<GetProThresholdValModel>.from(
        json.decode(str).map((x) => GetProThresholdValModel.fromJson(x)));

String projectThresholdValueModelToJson(
        List<GetProThresholdValModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProThresholdValModel {
  String id;
  SheetName sheetName;
  String columnName;
  bool isMandatory;
  bool isEditable;
  String? depends;
  String clientColumnName;
  ColumnDataType columnDataType;

  GetProThresholdValModel({
    required this.id,
    required this.sheetName,
    required this.columnName,
    required this.isMandatory,
    required this.isEditable,
    required this.depends,
    required this.clientColumnName,
    required this.columnDataType,
  });

  factory GetProThresholdValModel.fromJson(Map<String, dynamic> json) =>
      GetProThresholdValModel(
        id: json["id"],
        sheetName: sheetNameValues.map[json["sheet_name"]]!,
        columnName: json["column_name"],
        isMandatory: json["is_mandatory"],
        isEditable: json["is_editable"],
        depends: json["depends"],
        clientColumnName: json["client_column_name"],
        columnDataType: columnDataTypeValues.map[json["column_data_type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetNameValues.reverse[sheetName],
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

final sheetNameValues = EnumValues({
  "Customer Employee Basic data": SheetName.customerEmployeeBasicData,
  "Customer Employee Work data": SheetName.customerEmployeeWorkData,
  "Customer performance data": SheetName.customerPerformanceData
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
