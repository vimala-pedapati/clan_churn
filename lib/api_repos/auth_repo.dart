// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// enum AuthenticationStatus {
//   unknown,
//   authenticated,
//   unauthenticated,
//   exception,
//   sessionExpired
// }

// class AuthRepository {
//   FlutterSecureStorage storage;
//   AuthRepository({required this.storage});
//   final String apiUrl = 'http://churnapi.clanonline.in/sign_in';
//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//   };

//   Future<void> storeAccessToken(String authSession) async {
//     await storage.write(key: 'accessToken', value: authSession);
//   }

//   Future<void> storeRefreshToken(String refreshToken) async {
//     await storage.write(key: 'refreshToken', value: refreshToken);
//   }

//   Future<String?> getAuthSession() async {
//     return await storage.read(key: 'accessToken');
//   }

//   Future<String?> getRefreshToken() async {
//     return await storage.read(key: 'refreshToken');
//   }

//   Future<void> deleteAuthSession() async {
//     await storage.delete(key: 'accessToken');
//   }

//   Future<void> deleteRefreshToken() async {
//     await storage.delete(key: 'refreshToken');
//   }

//   Future<AuthenticationStatus> signInApiCall({required email, required password}) async {
//     final Map<String, dynamic> requestBody = {
//       "email": email,
//       "password": password
//     };

//     try {
//       final http.Response response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: json.encode(requestBody),
//       );

//       if (response.statusCode == 200) {
//         // Successful request
//         final Map<String, dynamic> data = json.decode(response.body);
//         String accessToken = data['access_token'];
//         String refreshToken = data['refresh_token'];
//         storeAccessToken(accessToken);
//         storeRefreshToken(refreshToken);
//         log("sign in response:..... $data");
//         return AuthenticationStatus.authenticated;
//         // Handle successful response
//       } else {
//         // Handle other status codes
//         log('Status Code: ${response.statusCode}');
//         // Handle errors based on status code
//         if (response.statusCode == 401) {
//           // Unauthorized
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           // Not found
//           log('API endpoint not found');
//         } else {
//           // Handle other status codes
//           log('Unexpected Error');
//         }
//       }
//       return AuthenticationStatus.unauthenticated;
//     } catch (e) {
//       // Handle network errors
//       log('Network Error: $e');
//       return AuthenticationStatus.exception;
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  exception,
  sessionExpired
}

class AuthCredentials extends Equatable {
  final String accessToken;
  final String refreshToken;
  const AuthCredentials(
      {required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class AuthRepository {
  final String apiUrl = 'http://churnapi.clanonline.in/sign_in';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<void> storeTokens(
      {required String accessToken, required String refreshToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<AuthCredentials> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';
    String refreshToken = prefs.getString('refreshToken') ?? '';
    return AuthCredentials(
        accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<AuthenticationStatus> signInApiCall(
      {required email, required password}) async {
    final Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    Future<void> clearTokens() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
    }

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        storeTokens(
            accessToken: data['access_token'],
            refreshToken: data['refresh_token']);
        log("sign in response:..... $data");
        return AuthenticationStatus.authenticated;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
      }
      return AuthenticationStatus.unauthenticated;
    } catch (e) {
      log('Network Error: $e');
      return AuthenticationStatus.exception;
    }
  }
}
