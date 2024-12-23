import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, exception, sessionExpired, pageNotFound }

class AuthCred extends Equatable {
  final String accessToken;
  final String refreshToken;
  const AuthCred({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class AuthRepo {
  final String signIn = BaseUrl.baseUrl + ApiEndpoints.signIn;

  Future<void> storeTokens({required String accessToken, required String refreshToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<AuthCred> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';
    String refreshToken = prefs.getString('refreshToken') ?? '';
    // if (kDebugMode) {
    //   print(accessToken);
    // }
    return AuthCred(accessToken: accessToken, refreshToken: refreshToken);
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

  Future<AuthStatus> signInApiCall({required email, required password}) async {
    final Map<String, dynamic> requestBody = {"email": email, "password": password};
    try {
      final http.Response response = await http.post(
        Uri.parse(signIn),
        headers: BaseUrl.headers,
        body: json.encode(requestBody),
      );
      log("auth response: $response");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        storeTokens(accessToken: data['access_token'], refreshToken: data['refresh_token']);
        log("1)${data['access_token']}");
        return AuthStatus.authenticated;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
          return AuthStatus.unauthenticated;
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
          return AuthStatus.pageNotFound;
        } else {
          log('Unexpected Error');
          return AuthStatus.unknown;
        }
      }
      // return AuthenticationStatus.unauthenticated;
    } catch (e) {
      log('Network Error: $e');
      return AuthStatus.exception;
    }
  }
}
