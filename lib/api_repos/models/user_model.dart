import 'dart:convert';

import 'package:equatable/equatable.dart';

enum UserType {
  admin,
  projectArchitect,
  clientHead,
  client,
}

extension UserTypesExtension on UserType {
  String get value {
    switch (this) {
      case UserType.admin:
        return 'admin';
      case UserType.projectArchitect:
        return 'Project Architect';
      case UserType.clientHead:
        return 'client_head';
      case UserType.client:
        return 'client';
      default:
        return "";
    }
  }
}

extension UserTypesParsing on String {
  UserType get toUserType {
    switch (this) {
      case 'admin':
        return UserType.admin;
      case 'Project Architect':
        return UserType.projectArchitect;
      case 'client_head':
        return UserType.clientHead;
      case 'client':
        return UserType.client;
      default:
        throw ArgumentError('Invalid UserType string: $this');
    }
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable {
  final ClientDetails? clientDetails;
  final String? firstName;
  final String lastName;
  final String email;
  final String userId;
  final UserType userType;
  final String? image;

  const User(
      {required this.clientDetails,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.userId,
      required this.userType,
      required this.image});

  factory User.fromJson(Map<String, dynamic> json) => User(
      clientDetails: json["client_details"] == null
          ? null
          : ClientDetails.fromJson(json["client_details"]),
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      userId: json["user_id"],
      userType: ((json["user_type"] ?? "") as String).toUserType,
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "client_details": clientDetails!.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_id": userId,
        "user_type": userType,
        "image": image
      };

  @override
  List<Object?> get props => [firstName, email, userType, image];
}

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

  const ClientDetails({
    required this.id,
    required this.name,
    required this.role,
    required this.address1,
    required this.address2,
    required this.pocName,
    required this.pocContactNumber,
    required this.pocMailId,
    required this.image,
  });

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
      );

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
      };

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        pocMailId,
      ];
}
