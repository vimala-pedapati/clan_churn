import 'dart:convert';

List<ColumnDetails> columnDetailsFromJson(String str) =>
    List<ColumnDetails>.from(
        json.decode(str).map((x) => ColumnDetails.fromJson(x)));

String columnDetailsToJson(List<ColumnDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColumnDetails {
  String id;
  String sheetName;
  String columnName;
  bool isMandatory;

  ColumnDetails({
    required this.id,
    required this.sheetName,
    required this.columnName,
    required this.isMandatory,
  });

  factory ColumnDetails.fromJson(Map<String, dynamic> json) => ColumnDetails(
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
