import 'package:clan_churn/api_repos/models/client_details.dart';
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
        return 'Admin';
      case UserType.projectArchitect:
        return 'Project Architect';
      case UserType.clientHead:
        return 'Client Head';
      case UserType.client:
        return 'Client';
      default:
        return "";
    }
  }
}

extension UserTypesParsing on String {
  UserType get toUserType {
    switch (this) {
      case 'Admin':
        return UserType.admin;
      case 'Project Architect':
        return UserType.projectArchitect;
      case 'Client Head':
        return UserType.clientHead;
      case 'Client':
        return UserType.client;
      default:
        throw ArgumentError('Invalid UserType string: $this');
    }
  }
}

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

// class User extends Equatable {
//   final ClientDetails? clientDetails;
//   final String? firstName;
//   final String lastName;
//   final String email;
//   final String userId;
//   final UserType userType;
//   final String? image;

//   const User({
//     required this.clientDetails,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.userId,
//     required this.userType,
//     required this.image,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         clientDetails: json["client_details"] == null ? null : ClientDetails.fromJson(json["client_details"]),
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         userId: json["user_id"],
//         userType: ((json["user_type"] ?? "") as String).toUserType,
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "client_details": clientDetails!.toJson(),
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "user_id": userId,
//         "user_type": userType,
//         "image": image,
//       };

//   @override
//   // List<Object?> get props => [firstName, email, userType, image];
//   List<Object?> get props => [userId, firstName, lastName, email, userType, image, clientDetails];
// }

class User extends Equatable {
  final ClientDetails? clientDetails;
  final String? firstName;
  final String lastName;
  final String email;
  final String userId;
  final UserType userType;
  final String? image;

  const User({
    required this.clientDetails,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userId,
    required this.userType,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        clientDetails: json["client_details"] == null ? null : ClientDetails.fromJson(json["client_details"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userId: json["user_id"],
        userType: ((json["user_type"] ?? "") as String).toUserType,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "client_details": clientDetails!.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_id": userId,
        "user_type": userType.value,
        "image": image,
      };
  User copyWith({
    ClientDetails? clientDetails,
    String? firstName,
    String? lastName,
    String? email,
    String? userId,
    UserType? userType,
    String? image,
  }) {
    return User(
      clientDetails: clientDetails ?? this.clientDetails,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [userId, firstName, lastName, email, userType, clientDetails, image];
  // List<Object?> get props => [
  //       userId,
  //     ];
}
