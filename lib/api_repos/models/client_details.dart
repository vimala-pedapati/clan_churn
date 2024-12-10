import 'dart:convert';

import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:equatable/equatable.dart';

List<ClientDetails> clientDetailsFromJson(String str) =>
    List<ClientDetails>.from(
        json.decode(str).map((x) => ClientDetails.fromJson(x)));

String clientDetailsToJson(List<ClientDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientDetails extends Equatable {
  final String id;
  final String name;
  final String? role;
  final String? address1;
  final String? address2;
  final String? pocName;
  final String? pocContactNumber;
  final String? pocMailId;
  final String? image;
  final List<User>? assignedProjectArc;

  const ClientDetails(
      {required this.id,
      required this.name,
      required this.role,
      required this.address1,
      required this.address2,
      required this.pocName,
      required this.pocContactNumber,
      required this.pocMailId,
      required this.image,
      required this.assignedProjectArc});

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails(
      id: json["id"],
      name: json["name"],
      role: json["role"],
      address1: json["address_1"],
      address2: json["address_2"],
      pocName: json["poc_name"],
      pocContactNumber: json["poc_contact_number"],
      pocMailId: json["poc_mail_id"],
      image: json["image"],
      assignedProjectArc: (json['assigned_users'] as List<dynamic>?)
          ?.map((user) => User.fromJson(user))
          .toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "address_1": address1,
        "address_2": address2,
        "poc_name": pocName,
        "poc_contact_number": pocContactNumber,
        "poc_mail_id": pocMailId,
        "image": image,
        "assigned_users": assignedProjectArc!
            .map(
              (e) => e.toJson(),
            )
            .toList()
      };

  @override
  List<Object?> get props => [id, name, role, pocMailId, image];
}
