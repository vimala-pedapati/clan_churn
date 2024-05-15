import 'dart:convert';
import 'dart:developer';

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

  const ColumnDetails(
      {required this.id,
      required this.sheetName,
      required this.columnName,
      required this.isMandatory,
      required this.isUserCheckedIn});

  factory ColumnDetails.fromJson(Map<String, dynamic> json) => ColumnDetails(
      id: json["id"],
      sheetName: json["sheet_name"],
      columnName: json["column_name"],
      isMandatory: json["is_mandatory"],
      isUserCheckedIn: json["is_mandatory"] ?? false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "sheet_name": sheetName,
        "column_name": columnName,
        "is_mandatory": isMandatory,
      };

  ColumnDetails copyWith({
    String? id,
    String? sheetName,
    String? columnName,
    bool? isMandatory,
    bool? isUserCheckedIn,
  }) {
    return ColumnDetails(
        id: id ?? this.id,
        sheetName: sheetName ?? this.sheetName,
        columnName: columnName ?? this.columnName,
        isMandatory: isMandatory ?? this.isMandatory,
        isUserCheckedIn: isUserCheckedIn ?? this.isUserCheckedIn);
  }

  @override
  List<Object?> get props => [columnName, isUserCheckedIn, ];
}
