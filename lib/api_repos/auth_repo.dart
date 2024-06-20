import 'dart:convert';
import 'dart:developer';
import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  exception,
  sessionExpired,
  pageNotFound
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
  final String signIn = BaseUrl.baseUrl + ApiEndpoints.signIn;
  final String forgotPass = BaseUrl.baseUrl + ApiEndpoints.signIn;

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
    if (kDebugMode) {
      print(accessToken);
    }
    return AuthCredentials(
        accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<bool> clearTokens() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool accessTokenRemoved = await prefs.remove('accessToken');
      if (accessTokenRemoved) {
        log("removed access token");
        bool refreshTokenRemoved = await prefs.remove('refreshToken');
        if (refreshTokenRemoved) {
          log("removed refresh token");
          getTokens();
          return true;
        }
      }
    } catch (error) {
      log("Error while clearing tokens: $error");
    }

    log("Failed to clear tokens");
    return false;
  }

  Future<AuthenticationStatus> signInApiCall(
      {required email, required password}) async {
    final Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(signIn),
        headers: BaseUrl.headers,
        body: json.encode(requestBody),
      );
      log("auth response: $response");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        storeTokens(
            accessToken: data['access_token'],
            refreshToken: data['refresh_token']);
        log("1)${data['access_token']}");
        return AuthenticationStatus.authenticated;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
          return AuthenticationStatus.unauthenticated;
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
          return AuthenticationStatus.pageNotFound;
        } else {
          log('Unexpected Error');
          return AuthenticationStatus.unknown;
        }
      }
      // return AuthenticationStatus.unauthenticated;
    } catch (e) {
      log('Network Error: $e');
      return AuthenticationStatus.exception;
    }
  }

  Future forgotPassword({required email}) async {
    final Map<String, dynamic> requestBody = {
      "email": email,
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(forgotPass),
        headers: BaseUrl.headers,
        body: json.encode(requestBody),
      );
      log("forgot password response: $response");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
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
      // return AuthenticationStatus.unauthenticated;
    } catch (e) {
      log('Network Error: $e');
    }
  }

 
}
