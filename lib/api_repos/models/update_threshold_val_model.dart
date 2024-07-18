// To parse this JSON data, do
//
//     final updateThresholdValModel = updateThresholdValModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<UpdateThresholdValModel> updateThresholdValModelFromJson(String str) =>
    List<UpdateThresholdValModel>.from(
        json.decode(str).map((x) => UpdateThresholdValModel.fromJson(x)));

String updateThresholdValModelToJson(List<UpdateThresholdValModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateThresholdValModel extends Equatable {
  final String columnId;
  final String columnType;
  final int minValue;
  final int maxValue;
  final int? outlierTopRank;
  final int? outlierBottomRank;

  const UpdateThresholdValModel({
    required this.columnId,
    required this.columnType,
    required this.minValue,
    required this.maxValue,
    this.outlierTopRank,
    this.outlierBottomRank,
  });

  factory UpdateThresholdValModel.fromJson(Map<String, dynamic> json) =>
      UpdateThresholdValModel(
        columnId: json["column_id"],
        columnType: json["column_type"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        outlierTopRank: json["outlier_top_rank"],
        outlierBottomRank: json["outlier_bottom_rank"],
      );

  Map<String, dynamic> toJson() => {
        "column_id": columnId,
        "column_type": columnType,
        "min_value": minValue,
        "max_value": maxValue,
        "outlier_top_rank": outlierTopRank,
        "outlier_bottom_rank": outlierBottomRank,
      };

  @override
  List<Object?> get props => [
        columnId,
        columnType,
        minValue,
        maxValue,
        outlierTopRank,
        outlierBottomRank
      ];
}
