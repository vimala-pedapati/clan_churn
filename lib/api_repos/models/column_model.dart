import 'dart:convert';

import 'package:equatable/equatable.dart';

List<ColumnDetails> columnDetailsFromJson(String str) =>
    List<ColumnDetails>.from(
        json.decode(str).map((x) => ColumnDetails.fromJson(x)));

String columnDetailsToJson(List<ColumnDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColumnDetails extends Equatable {
  final String id;
  final String sheetName;
  final String columnName;
  final bool isMandatory;
  final bool isUserCheckedIn;
  final String customerColumnName;

  const ColumnDetails(
      {required this.id,
      required this.sheetName,
      required this.columnName,
      required this.isMandatory,
      required this.isUserCheckedIn,
      required this.customerColumnName});

  factory ColumnDetails.fromJson(Map<String, dynamic> json) => ColumnDetails(
      id: json["id"],
      sheetName: json["sheet_name"],
      columnName: json["column_name"],
      isMandatory: json["is_mandatory"],
      isUserCheckedIn: json["is_mandatory"] ?? false,
      customerColumnName:
          json["customer_column_name"] ?? json["column_name"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetName,
        "column_name": columnName,
        "is_mandatory": isMandatory,
        "customer_column_name": customerColumnName
      };

  ColumnDetails copyWith(
      {String? id,
      String? sheetName,
      String? columnName,
      bool? isMandatory,
      bool? isUserCheckedIn,
      String? customerColumnName}) {
    return ColumnDetails(
        id: id ?? this.id,
        sheetName: sheetName ?? this.sheetName,
        columnName: columnName ?? this.columnName,
        isMandatory: isMandatory ?? this.isMandatory,
        isUserCheckedIn: isUserCheckedIn ?? this.isUserCheckedIn,
        customerColumnName: customerColumnName ?? this.customerColumnName);
  }

  @override
  List<Object?> get props => [
        columnName,
        isUserCheckedIn,
        customerColumnName
      ];
}
