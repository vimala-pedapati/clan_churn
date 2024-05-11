// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/api_endpoins.dart';

class ApiRepository {
  AuthCredentials authCredentials;
  ApiRepository({
    required this.authCredentials,
  });
  Future<User?> getUserDetails() async {
    log("access token: ${authCredentials.accessToken}");
    try {
      final http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        log("getUserResponse:..... $data");
        return null;
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
      return null;
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

}
