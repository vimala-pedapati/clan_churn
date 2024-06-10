import 'dart:convert';
import 'dart:developer';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_history_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/api_endpoins.dart';

typedef OnErrorCallback = void Function(String errorMessage, int errorCode);
typedef OnSuccessCallback = void Function(http.Response? message);

class ApiRepository {
  Future<String?> checkAuth({required OnErrorCallback onErrorCallback}) async {
    final AuthCredentials authCredentials = await AuthRepository().getTokens();

    if (authCredentials.accessToken.isEmpty) {
      log('Access token is empty');
      onErrorCallback('Access token is empty', 0);
      return null;
    } else {
      return authCredentials.accessToken;
    }
  }

  Future<User?> getUserDetails(
      {required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        User user = User.fromJson(data);
        log("getUserResponse:..... $data");
        return user;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<List<ClientDetails>?> getClientsList(
      {required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientsList}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List<ClientDetails> clientDetails =
            clientDetailsFromJson(response.body);
        print("Clients:..... $clientDetails");
        return clientDetails;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<List<Project>?> getAllProjectDetails({
    required String clientId,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllProjects}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode({"client_id": clientId}),
      );

      if (response.statusCode == 200) {
        List<Project> listOfProjects = projectFromJson(response.body);
        log("List of Projects:..... $listOfProjects");
        return listOfProjects;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  // Get error report for a specific input
  Future<LatestInputModel?> getErrorReportForInput(
      {required String inputId,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    log("......get error report $inputId");
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
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode(inputId));

      log("${ApiEndpoints.getErrorReport} api response : $response");
      if (response.statusCode == 200) {
        LatestInputModel res =
            LatestInputModel.fromJson(json.decode(response.body));
        log("${ApiEndpoints.getErrorReport} response : $res");
        onSuccessCallback(response);
        return res;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('${ApiEndpoints.getErrorReport}:  Network Error: $e');
    }
    return null;
  }

  Future<Project?> updateProjectDetails({
    required String projectId,
    required ProjectDetails projectDetails,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateProjectDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode({
          "project_id": projectId,
          "project_details": projectDetails.toJson()
        }),
      );

      log(json.encode({
        "project_id": projectId,
        "project_details": projectDetails.toJson()
      }));

      if (response.statusCode == 200) {
        Project project = Project.fromJson(json.decode(response.body));
        log("Updated project:..... $project");
        return project;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<Project?> getProjectDetails({
    required String projectId,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getProjectDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode({
          "project_id": projectId,
        }),
      );

      log("get project:..... $response");

      if (response.statusCode == 200) {
        Project project = Project.fromJson(json.decode(response.body));
        log("get project:..... ${response.body}");
        log("get project:..... $project");
        return project;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<Project?> createProject(
      {required String clientId,
      required String projectName,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addProject}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode({"client_id": clientId, "name": projectName}),
      );

      if (response.statusCode == 200) {
        Project createdProject = Project.fromJson(json.decode(response.body));
        log("Created Project:..... $createdProject");
        onSuccessCallback(response);
        return createdProject;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<List<ColumnDetails>?> getAllColumns(
      {required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllColumns}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List<ColumnDetails> columnsList = columnDetailsFromJson(response.body);
        log("List of Columns:..... $columnsList");
        return columnsList;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<Project?> addColumnsToProject({
    required List columnsToAdd,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addColumnsToProject}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode(columnsToAdd),
      );

      log("Columns to add:..... $columnsToAdd");

      if (response.statusCode == 200) {
        Project updatedProject = Project.fromJson(json.decode(response.body));
        log("Updated project with columns:..... $updatedProject");
        return updatedProject;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  Future<Project?> updateProjectName(
      {required OnErrorCallback onErrorCallback,
      required String updatedProjectName,
      required String projectId,
      required OnSuccessCallback onSuccessCallback}) async {
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
        Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.updateProjectName}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
        body: json.encode({
          "project_id": projectId,
          "name": updatedProjectName,
        }),
      );

      // Handle API response
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("Response: ${response.body}");
        Project updatedProjectDetails = Project.fromJson(data);
        onSuccessCallback(response);
        return updatedProjectDetails;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      log("updateProjectName exception: $e");
      onErrorCallback('Network Error: $e', 0);
      return null;
    }
  }

  // Upload a file for a project
  Future<Project?> uploadFile(
      {required String projectId,
      required FilePickerResult filePickerResult,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      // Fetch auth credentials
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      // Check if auth credentials are null
      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        return null;
      }

      if (filePickerResult.files.isNotEmpty) {
        PlatformFile file = filePickerResult.files.first;
        var headers = {
          'Authorization': 'Bearer ${authCredentials.accessToken}'
        };
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.uploadFile}'),
        );
        request.fields.addAll({'project_id': projectId});

        if (file.bytes != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'input_sheet',
            file.bytes!,
            filename: file.name,
          ));
        }
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        log(response.reasonPhrase ?? 'No Reason Phrase');
        if (response.statusCode == 200) {
          String responseString = await response.stream.bytesToString();
          log(responseString);
          Project project = Project.fromJson(json.decode(responseString));
          onSuccessCallback(null);
          return project;
        } else {
          _handleStatusCode(
              response.statusCode, response.reasonPhrase, onErrorCallback);
          return null;
        }
      } else {
        log('File picking canceled');
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Network Error: $e', 0);
    }
    return null;
  }

  Future getInputExcelSummaryReport(
      {required String inputId,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getInputExcelSummary}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode(inputId));

      if (response.statusCode == 200) {
        onSuccessCallback(response);
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
      }
    } catch (e) {
      log("get summary report: $e");
    }
  }

  Future<List<ProjectHistoryModel>?> getProjectHistoryDetails(
      {required String projectId,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

      if (authCredentials.accessToken.isEmpty) {
        log('Access token is empty');
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.projectInputHistory}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode(projectId));
      if (response.statusCode == 200) {
        onSuccessCallback(response);
        List<ProjectHistoryModel> history =
            projectHistoryModelFromJson(response.body);
        return history;
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
      }
    } catch (e) {
      log("Project Input History: $e");
    }
    return null;
  }

  // Get error report for a specific input
  Future<String?> generateMarts(
      {required String inputId,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    log("......get error report $inputId");
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
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.generateMarts}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode(inputId));

      log("${ApiEndpoints.generateMarts} api response : $response");
      if (response.statusCode == 200) {
        log("${ApiEndpoints.generateMarts} api response : ${response.body}");
        // LatestInputModel res = LatestInputModel.fromJson(json.decode(response.body));
        // print("${ApiEndpoints.getErrorReport} response : ${res}");
        onSuccessCallback(response);
        return json.decode(response.body);
      } else {
        _handleStatusCode(
            response.statusCode, response.reasonPhrase, onErrorCallback);
        return null;
      }
    } catch (e) {
      print('${ApiEndpoints.generateMarts}:  Network Error: $e');
    }
    return null;
  }

  void _handleStatusCode(
      int statusCode, String? reasonPhrase, OnErrorCallback onErrorCallback) {
    switch (statusCode) {
      case 400:
        onErrorCallback('Bad request: $reasonPhrase', 400);
        break;
      case 401:
        onErrorCallback('Unauthorized: $reasonPhrase', 401);
        break;
      case 403:
        onErrorCallback('Forbidden: $reasonPhrase', 403);
        break;
      case 404:
        onErrorCallback('Not found: $reasonPhrase', 404);
        break;
      case 422:
        onErrorCallback(
            'Invalid format. Please check your input and try again.: $reasonPhrase',
            422);
        break;
      case 500:
        onErrorCallback('Internal server error: $reasonPhrase', 500);
        break;
      default:
        onErrorCallback('Unexpected error: $reasonPhrase', 0);
    }
  }

  void handleWarningMessage(
      String message, BuildContext context, int errorCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void handleSuccessMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
