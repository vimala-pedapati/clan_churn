// import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));
// String userToJson(User data) => json.encode(data.toJson());

// class User {
//   String? firstName;
//   String? lastName;
//   String? email;
//   String userId;
//   String? client;
//   String? role;
//   String? profileUrl;

//   User(
//       {required this.firstName,
//       required this.lastName,
//       required this.email,
//       required this.userId,
//       required this.client,
//       required this.role,
//       required this.profileUrl});

//   factory User.fromJson(Map<String, dynamic> json) => User(
//       firstName: json["first_name"] ?? "first name",
//       lastName: json["last_name"] ?? "last name",
//       email: json["email"] ?? "example@gmail.com",
//       userId: json["user_id"],
//       client: json["clinet"] ?? "client name",
//       role: json["role"] ?? "no role",
//       profileUrl: json["profile_url"] ?? "");

//   Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "user_id": userId,
//       };
// }



// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    ClientDetails clientDetails;
    String firstName;
    String lastName;
    String email;
    String userId;
    String userType;

    User({
        required this.clientDetails,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.userId,
        required this.userType,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        clientDetails: ClientDetails.fromJson(json["client_details"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userId: json["user_id"],
        userType: json["user_type"],
    );

    Map<String, dynamic> toJson() => {
        "client_details": clientDetails.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_id": userId,
        "user_type": userType,
    };
}

class ClientDetails {
    String id;
    String name;
    dynamic role;
    dynamic address1;
    dynamic address2;
    dynamic pocName;
    dynamic pocContactNumber;
    dynamic pocMailId;
    String image;

    ClientDetails({
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
}
