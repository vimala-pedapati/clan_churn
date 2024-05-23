// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:http/http.dart' as http;

import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/api_endpoins.dart';

class ApiRepository {
  // To fetch user details
  Future<User?> getUserDetails() async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      // Handle API response
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        User user = User.fromJson(data);
        log("getUserResponse:..... $data");
        return user;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

  // To fetch clients list
  Future<List<ClientDetails>?> getClientsList() async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientsList}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        List<ClientDetails> clientDetails =
            clientDetailsFromJson(response.body);
        log("Clients:..... $clientDetails");
        return clientDetails;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

// To fetch projects list
  Future<List<Project>?> getProjectDetails(
      {required String clientId}) async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllProjects}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode({"client_id": clientId}));

      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        List<Project> listOfProjects =
            projectFromJson(response.body);
        for (var i in json.decode(response.body)) {
          print("project: $i");
        }
        print("List of Projects:..... $listOfProjects");
        return listOfProjects;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      print('Network Error: $e');
      return null;
    }
  }

// To add project
  Future<Project?> createProject(
      {required String clientId, required String projectName}) async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addProject}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode({"client_id": clientId, "name": projectName}));

      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        Project createdProject =
            Project.fromJson(json.decode(response.body));

        log("Created Project:..... $createdProject");
        return createdProject;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

// To get all columns
  Future<List<ColumnDetails>?> getAllColumns() async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllColumns}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        List<ColumnDetails> columnsList = columnDetailsFromJson(response.body);
        log("List of Columns:..... $columnsList");
        return columnsList;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

// Add columns to project
  Future<Project?> addColumnsToProject(
      {required List columnsToAdd}) async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addColumnsToProject}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode(columnsToAdd));

      // Handle API response
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(" response: ${response.body}");
        Project updatedProjectDetails = Project.fromJson(data);
        // log("Updated Project Details:..... $updatedProjectDetails");
        return updatedProjectDetails;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }
}
