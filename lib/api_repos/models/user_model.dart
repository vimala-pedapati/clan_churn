import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String? firstName;
  String? lastName;
  String? email;
  String userId;
  String? client;
  String? role;
  String? profileUrl;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.userId,
      required this.client,
      required this.role,
      required this.profileUrl});

  factory User.fromJson(Map<String, dynamic> json) => User(
      firstName: json["first_name"] ?? "first name",
      lastName: json["last_name"] ?? "last name",
      email: json["email"] ?? "example@gmail.com",
      userId: json["user_id"],
      client: json["clinet"] ?? "client name",
      role: json["role"] ?? "no role",
      profileUrl: json["profile_url"] ?? "");

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_id": userId,
      };
}
