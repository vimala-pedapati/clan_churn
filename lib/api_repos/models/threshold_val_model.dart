import 'dart:convert';

import 'package:equatable/equatable.dart';

List<ProThreModel> proThresholdModelFromJson(String str) =>
    List<ProThreModel>.from(
        json.decode(str).map((x) => ProThreModel.fromJson(x))).toList();

class ProThreModel extends Equatable {
  final String columnId;
  final String? columnType;
  final int? minValue;
  final int? maxValue;
  final int? outlierTopRank;
  final int? outlierBottomRank;
  final int status;
  final String? createdBy;
  final String createdAt;
  final String? modifiedBy;
  final String? modifiedAt;

  const ProThreModel({
    required this.columnId,
    required this.columnType,
    required this.minValue,
    required this.maxValue,
    required this.outlierTopRank,
    required this.outlierBottomRank,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory ProThreModel.fromJson(Map<String, dynamic> json) {
    return ProThreModel(
      columnId: json['column_id'],
      columnType: json['column_type'],
      minValue: json['min_value'],
      maxValue: json['max_value'],
      outlierTopRank: json['outlier_top_rank'],
      outlierBottomRank: json['outlier_bottom_rank'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      modifiedBy: json['modified_by'],
      modifiedAt: json['modified_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'column_id': columnId,
      'column_type': columnType,
      'min_value': minValue,
      'max_value': maxValue,
      'outlier_top_rank': outlierTopRank,
      'outlier_bottom_rank': outlierBottomRank,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt,
      'modified_by': modifiedBy,
      'modified_at': modifiedAt,
    };
  }

  @override
  List<Object?> get props => [
        columnId,
        columnType,
        minValue,
        maxValue,
        outlierTopRank,
        outlierBottomRank,
        status,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
      ];
}
