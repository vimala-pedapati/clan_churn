import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/api_repos/models/client_logo_upload_res.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/project_history_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/update_threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/components/custom_snack_bar.dart';
import 'package:clan_churn/components/show_top_snack_bar.dart';
import 'package:clan_churn/utils/api_endpoins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

typedef OnErrorCallback = void Function(String errorMessage, int errorCode);
typedef OnSuccessCallback = void Function(http.Response? message);

class ApiRepository {
  Future<String?> checkAuth({required OnErrorCallback onErrorCallback}) async {
    final AuthCred authCred = await AuthRepo().getTokens();

    if (authCred.accessToken.isEmpty) {
      onErrorCallback('Access token is empty', 0);
      return null;
    } else {
      return authCred.accessToken;
    }
  }

  Future<User?> getUserDetails({required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        User user = User.fromJson(data);
        log("getUserResponse:..... $data");
        return user;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        onErrorCallback('$response', response.statusCode);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to fetch user details please contact admin', 0);
      return null;
    }
  }

  Future<List<User>?> getAllUsers({required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      // final http.Response response = await http.post(
      //   Uri.parse(
      //       "${BaseUrl.baseUrl}${ApiEndpoints.getAllUsers}?client_id=$clientId"),
      final http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllUsers}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<User> users = data.map((user) => User.fromJson(user)).toList();
        log("getAllUsersResponse:..... $data");
        onSuccessCallback(response);
        return users;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        onErrorCallback('$response', response.statusCode);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Unable to fetch all users please contact admin', 0);
      return null;
    }
  }

  Future<List<ClientDetails>?> getClientsList({required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      final http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientsList}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List<ClientDetails> clientDetails = clientDetailsFromJson(response.body);
        // print("Clients:..... $clientDetails");
        onSuccessCallback(response);
        return clientDetails;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to fetch clients list please contact admin', 0);
      return null;
    }
  }

  Future<List<Project>?> getAllProjectDetails({
    required String clientId,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllProjects}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
        body: json.encode({"client_id": clientId}),
      );

      if (response.statusCode == 200) {
        List<Project> listOfProjects = projectFromJson(response.body);
        // print("List of Projects:..... $listOfProjects");
        return listOfProjects;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to fetch existing projects please contact admin', 0);
      return null;
    }
  }

  // Get error report for a specific input
  Future<LatestInputModel?> getErrorReportForInput({required String inputId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    log("......get error report $inputId");
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode(inputId));

      log("${ApiEndpoints.getErrorReport} api response : $response");
      if (response.statusCode == 200) {
        LatestInputModel res = LatestInputModel.fromJson(json.decode(response.body));
        log("${ApiEndpoints.getErrorReport} response : $res");
        onSuccessCallback(response);
        return res;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('${ApiEndpoints.getErrorReport}:  Network Error: $e');
      onErrorCallback('Unable to fetch error report for input sheet please contact admin', 0);
    }
    return null;
  }

  Future<Project?> updateProjectDetails({
    required String projectId,
    required ProjectDetails projectDetails,
    required OnSuccessCallback onSuccessCallback,
    required OnErrorCallback onErrorCallback,
  }) async {
    print("project id: $projectId");
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateProjectDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
        body: json.encode({"project_id": projectId, "project_details": projectDetails.toJson()}),
      );

      print(json.encode({"project_id": projectId, "project_details": projectDetails.toJson()}));

      if (response.statusCode == 200) {
        Project project = Project.fromJson(json.decode(response.body));
        // print("Updated project:..... ${response.body}");
        onSuccessCallback(response);
        return project;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to update project details please contact admin', 0);
      return null;
    }
  }

  Future<Project?> getProjectDetails({
    required String projectId,
    required OnErrorCallback onErrorCallback,
  }) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getProjectDetails}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
        body: json.encode({
          "project_id": projectId,
        }),
      );

      if (response.statusCode == 200) {
        Project project = Project.fromJson(json.decode(response.body));
        return project;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      onErrorCallback('unable to fectch the project details, please contact admin', 0);
      return null;
    }
  }

  Future<Project?> createProject({required String clientId, required String projectName, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addProject}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
        body: json.encode({"client_id": clientId, "name": projectName}),
      );

      if (response.statusCode == 200) {
        Project createdProject = Project.fromJson(json.decode(response.body));
        log("Created Project:..... $createdProject");
        onSuccessCallback(response);
        return createdProject;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Unable to create project, please contact admin', 0);
      return null;
    }
  }

  Future<List<ColumnDetails>?> getAllColumns({required String? projectId, required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllColumns}?project_id=$projectId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List<ColumnDetails> columnsList = columnDetailsFromJson(response.body);
        log("List of Columns:..... $columnsList");
        return columnsList;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Unable to get columns, please contact admin', 0);
      return null;
    }
  }

  Future<Project?> addColumnsToProject({required List columnsToAdd, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addColumnsToProject}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
        body: json.encode(columnsToAdd),
      );

      log("Columns to add:..... $columnsToAdd");

      if (response.statusCode == 200) {
        Project updatedProject = Project.fromJson(json.decode(response.body));
        log("Updated project with columns:..... $updatedProject");
        onSuccessCallback(response);
        return updatedProject;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      print('Network Error: $e');
      onErrorCallback('unable to add columns to the project please contact admin', 0);
      return null;
    }
  }

  Future<Project?> updateProjectName({required OnErrorCallback onErrorCallback, required String updatedProjectName, required String projectId, required OnSuccessCallback onSuccessCallback}) async {
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(
        Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.updateProjectName}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
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
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      log("updateProjectName exception: $e");
      onErrorCallback('unable to update project name/project name already exists please contact admin', 0);
      return null;
    }
  }

  // Upload a file for a project
  Future<Project?> uploadFile({required String projectId, required FilePickerResult filePickerResult, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      if (filePickerResult.files.isNotEmpty) {
        PlatformFile file = filePickerResult.files.first;
        var headers = {'Authorization': 'Bearer ${authCred.accessToken}'};
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

        if (response.statusCode == 200) {
          String responseString = await response.stream.bytesToString();
          log(responseString);
          Project project = Project.fromJson(json.decode(responseString));
          onSuccessCallback(null);
          return project;
        } else {
          _handleStatusCode(response.statusCode, await http.Response.fromStream(response), onErrorCallback);
          return null;
        }
      } else {
        log('File picking canceled');
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to update file please contact admin', 0);
    }
    return null;
  }

  // Upload error glosary sheet
  Future uploadErrorGlossarys({
    required FilePickerResult filePickerResult,
    required OnErrorCallback onErrorCallback,
    required OnSuccessCallback onSuccessCallback,
  }) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      if (filePickerResult.files.isNotEmpty) {
        PlatformFile file = filePickerResult.files.first;
        var headers = {'Authorization': 'Bearer ${authCred.accessToken}'};
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.updateErrorGlossary}'),
        );
        if (file.bytes != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'file',
            file.bytes!,
            filename: file.name,
          ));
        }
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          http.Response fullResponse = await http.Response.fromStream(response);
          onSuccessCallback(fullResponse);
        } else {
          _handleStatusCode(response.statusCode, await http.Response.fromStream(response), onErrorCallback);
        }
      } else {
        log('File picking canceled');
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('unable to update file please contact admin', 0);
    }
  }

  Future getInputExcelSummaryReport({required String inputId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getInputExcelSummary}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode(inputId));

      if (response.statusCode == 200) {
        onSuccessCallback(response);
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("get summary report: $e");
      onErrorCallback('unable to fetch input excel summary report please contact admin', 0);
    }
  }

  Future<List<ProjectHistoryModel>?> getProjectHistoryDetails({required String projectId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.projectInputHistory}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode(projectId));
      if (response.statusCode == 200) {
        onSuccessCallback(response);
        List<ProjectHistoryModel> history = projectHistoryModelFromJson(response.body);
        return history;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("Project Input History: $e");
      onErrorCallback('unable to get the project history please contact admin', 0);
    }
    return null;
  }

  // Get error report for a specific input
  Future<String?> generateMarts({required String inputId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    log("......get error report $inputId");
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      // Make API call with access token
      http.Response response = await http.post(Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.generateMarts}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
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
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      print('${ApiEndpoints.generateMarts}:  Network Error: $e');
      onErrorCallback('Unable to genetate marts please contact admin', 0);
    }
    return null;
  }

  Future<String?> getReportData({required String reportname, required String inputId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    // Fetch auth credentials
    final AuthCred authCred = await AuthRepo().getTokens();

    // Check if auth credentials are null
    if (authCred.accessToken.isEmpty) {
      return null;
    }

    try {
      // Make API call with access token
      http.Response response = await http.post(
        Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.getReportData}?report_name=$reportname&input_id=$inputId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      print("...${response.statusCode}..$response");

      if (response.statusCode == 200) {
        onSuccessCallback(response);

        return response.body;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
        return null;
      }
    } catch (e) {
      onErrorCallback('Unable to get report data please contact admin', 0);
      return null;
    }
  }

  Future clientCreate(
      {required String clientName,
      required String roleName,
      required String address1,
      required String address2,
      required String pocName,
      required String pocContactNumber,
      required String pocMailId,
      required String image,
      required List<String> assignedProjectArc,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientCreate}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode({"name": clientName, "role": roleName, "address_1": address1, "address_2": address2, "poc_name": pocName, "poc_contact_number": pocContactNumber, "poc_mail_id": pocMailId, "image": image, "assigned_users": assignedProjectArc}));
      print(" create client reponse: $response");
      if (response.statusCode == 200) {
        onSuccessCallback(response);
        // ClientDetails clientDetails =
        //     ClientDetails.fromJson(json.decode(response.body));
        print(" create client reponse: ${response.body}");
        // return clientDetails;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("get summary report: $e");
      onErrorCallback('Unable to create client please contact admin', 0);
    }
    return null;
  }

  Future<ClientDetails?> clientUpdate(
      {required String clientId,
      required String clientName,
      required String roleName,
      required String address1,
      required String address2,
      required String pocName,
      required String pocContactNumber,
      required String pocMailId,
      required String? image,
      required List<String> assignedProjectArc,
      required OnErrorCallback onErrorCallback,
      required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientUpdate}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode({"client_id": clientId, "name": clientName, "role": roleName, "address_1": address1, "address_2": address2, "poc_name": pocName, "poc_contact_number": pocContactNumber, "poc_mail_id": pocMailId, "image": image, "assigned_users": assignedProjectArc}));

      if (response.statusCode == 200) {
        ClientDetails clientDetails = ClientDetails.fromJson(json.decode(response.body));
        onSuccessCallback(response);
        return clientDetails;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("get summary report: $e");
      onErrorCallback('Unable to update file please contact admin', 0);
    }
    return null;
  }

  Future<UploadLogoResponse?> uploadClientLogo({required FilePickerResult filePickerResult, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      if (filePickerResult.files.isNotEmpty) {
        PlatformFile file = filePickerResult.files.first;
        var headers = {'Authorization': 'Bearer ${authCred.accessToken}'};
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.uploadLogo}?document_type=client'),
        );
        // request.fields.addAll({'project_id': projectId});

        if (file.bytes != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'image_logo',
            file.bytes!,
            filename: file.name,
          ));
        }
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          String responseString = await response.stream.bytesToString();
          print(responseString);
          UploadLogoResponse imageUrl = UploadLogoResponse.fromJson(json.decode(responseString));
          print(imageUrl);
          onSuccessCallback(null);
          return imageUrl;
        } else {
          _handleStatusCode(response.statusCode, await http.Response.fromStream(response), onErrorCallback);
          return null;
        }
      } else {
        print('Client Logo Upload Canceled');
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Unable to upload client logo please contact admin', 0);
    }
    return null;
  }

  Future<ClientDetails?> getClientDetails({required String clientId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getClient}?client_id=$clientId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        ClientDetails clientDetails = ClientDetails.fromJson(json.decode(response.body));
        onSuccessCallback(response);
        return clientDetails;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      onErrorCallback('Unable to delete client please contact admin', 0);
    }
    return null;
  }

  Future<bool?> deleteClient({required String clientId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.delete(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.deleteClient}?client_id=$clientId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        onSuccessCallback(response);

        return true;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("delete client: $e");
      onErrorCallback('Unable to delete client please contact admin', 0);
    }
    return false;
  }

  Future<bool?> addUser({required String? clientId, required String firstName, required String? lastName, required String email, required String password, required String userType, required String? image, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }
      print("................BEfore making api cal");
      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addUser}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode({"client_id": null, "first_name": firstName, "last_name": lastName, "email": email, "password": password, "user_type": userType, 'image_url': image}));
      print("................BEfore making api cal");
      if (response.statusCode == 200) {
        onSuccessCallback(response);
        return true;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("add user: $e");
      onErrorCallback('Unable to add user please contact admin', 0);
    }
    return false;
  }

  Future<bool?> updateUser({required String? clientId, required String firstName, required String? lastName, required String userId, required String? password, required String userType, required String? image, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }
      http.Response response = await http.post(Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateUser}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: json.encode({"client_id": null, "first_name": firstName, "last_name": null, "user_id": userId, "password": password, "user_type": userType, "image_url": image}));

      print("update user response : $response");
      if (response.statusCode == 200) {
        onSuccessCallback(response);
        print("update user response : ${response.body}");
        return true;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("update user: $e");
      onErrorCallback('Unable to update user please contact admin', 0);
    }
    return false;
  }

  Future<UploadLogoResponse?> uploadUserPic({required FilePickerResult filePickerResult, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      // Fetch auth credentials
      final AuthCred authCred = await AuthRepo().getTokens();

      // Check if auth credentials are null
      if (authCred.accessToken.isEmpty) {
        return null;
      }

      if (filePickerResult.files.isNotEmpty) {
        PlatformFile file = filePickerResult.files.first;
        var headers = {'Authorization': 'Bearer ${authCred.accessToken}'};
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.uploadLogo}?document_type=user'),
        );
        // request.fields.addAll({'project_id': projectId});

        if (file.bytes != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'image_logo',
            file.bytes!,
            filename: file.name,
          ));
        }
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          String responseString = await response.stream.bytesToString();
          print(responseString);
          UploadLogoResponse imageUrl = UploadLogoResponse.fromJson(json.decode(responseString));
          print(imageUrl);
          onSuccessCallback(Response(responseString, response.statusCode));
          return imageUrl;
        } else {
          _handleStatusCode(response.statusCode, await http.Response.fromStream(response), onErrorCallback);
          return null;
        }
      } else {
        log('Profile pic Upload Canceled');
      }
    } catch (e) {
      log('Network Error: $e');
      onErrorCallback('Unable to upload profile pic please contact admin', 0);
    }
    return null;
  }

  Future<List<String>?> getUserTypes({required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserTypes}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );
      print(response);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        print((json.decode(response.body)).runtimeType);
        List<dynamic> res = json.decode(response.body);
        onSuccessCallback(response);
        List<String> r = [];
        for (var i in res) {
          r.add(i.toString());
        }
        print(r);
        print(r.runtimeType);
        return r;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log(" get user types : $e");
      onErrorCallback('Unable to fetch user types please contact admin', 0);
    }
    return null;
  }

  Future<bool?> deleteUser({required String userId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.delete(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.deleteUser}?user_id=$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        onSuccessCallback(response);
        return true;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("delete user: $e");
      onErrorCallback('Unable to delete user please contact admin', 0);
    }
    return false;
  }

  Future<bool?> archiveProject({required String projectId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.archiveProject}?project_id=$projectId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        onSuccessCallback(response);
        return true;
      } else {
        _handleStatusCode(response.statusCode, response, onErrorCallback);
      }
    } catch (e) {
      log("archive project: $e");
      onErrorCallback('Unable to archive the project please contact admin', 0);
    }
    return false;
  }

  Future<List<GetProThresholdFormValModel>?> getProThresholdValues({required String projectId, required OnErrorCallback onErrorCallback, required OnSuccessCallback onSuccessCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();

      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response res = await http.post(
        Uri.parse(
          "${BaseUrl.baseUrl}${ApiEndpoints.getProThrDtls}?project_id=$projectId",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );
      if (res.statusCode == 200) {
        onSuccessCallback(res);
        print("......");
        List<GetProThresholdFormValModel> data = projectThresholdFormValueModelFromJson(res.body);
        print("......$data");
        return data;
      } else {
        _handleStatusCode(res.statusCode, res, onErrorCallback);
      }
    } catch (e) {
      log("unable to fetch project threshold values");
    }
    return null;
  }

  Future<Project?> updateThresholdValue({required String projectId, required List<UpdateThresholdValModel> data, required OnSuccessCallback onSuccessCallback, required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response res = await http.post(
          Uri.parse(
            "${BaseUrl.baseUrl}${ApiEndpoints.updateProThrVals}?project_id=$projectId",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCred.accessToken}',
          },
          body: updateThresholdValModelToJson(data));
      if (res.statusCode == 200) {
        onSuccessCallback(res);
        Project project = Project.fromJson(json.decode(res.body));
        return project;
      } else {}
    } catch (e) {
      onErrorCallback('Unable to update threshold values please contact admin', 0);
    }
    return null;
  }

  Future<List<String>?> getAllReports({required OnSuccessCallback onSuccessCallback, required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response res = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllReports}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );
      if (res.statusCode == 200) {
        onSuccessCallback(res);
        List<String> allReports = (json.decode(res.body) as Iterable)
            .map(
              (e) => e.toString(),
            )
            .toList();
        return allReports;
      } else {}
    } catch (e) {
      onErrorCallback('Unable to get all reports', 0);
    }
    return null;
  }

  Future downLoadReportApi({required OnSuccessCallback onSuccessCallback, required OnErrorCallback onErrorCallback, required String inputId, required String reportName}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response res = await http.post(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.downloadReport}?input_id=$inputId&report_name=$reportName"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );
      if (res.statusCode == 200) {
        onSuccessCallback(res);
      } else {}
    } catch (e) {
      onErrorCallback('Unable to update threshold values please contact admin', 0);
    }
    return null;
  }

  Future downloadErrorGlossary({required OnSuccessCallback onSuccessCallback, required OnErrorCallback onErrorCallback}) async {
    try {
      final AuthCred authCred = await AuthRepo().getTokens();
      if (authCred.accessToken.isEmpty) {
        onErrorCallback('Access token is empty', 0);
        return null;
      }

      http.Response res = await http.get(
        Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.downloadErrorGlossary}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCred.accessToken}',
        },
      );
      if (res.statusCode == 200) {
        onSuccessCallback(res);
      } else {}
    } catch (e) {
      onErrorCallback('Unable to download error glossary', 0);
    }
    return null;
  }

  void _handleStatusCode(int statusCode, Response response, OnErrorCallback onErrorCallback) {
    String reason = "${(json.decode(response.body) as Map<String, dynamic>)["detail"]}";

    switch (statusCode) {
      // case 400:
      //   onErrorCallback('Bad request: $response', 400);
      //   break;
      // case 401:
      //   onErrorCallback('Unauthorized: $response', 401);
      //   break;
      // case 403:
      //   onErrorCallback('Forbidden: $response', 403);
      //   break;
      // case 404:
      //   onErrorCallback('Not found: $response', 404);
      //   break;
      // case 422:
      //   onErrorCallback(
      //       'Invalid format. Please check your input and try again.: $response',
      //       422);
      //   break;
      case 500:
        onErrorCallback('Internal server error: $response', statusCode);
        break;
      default:
        onErrorCallback(reason, statusCode);
    }
  }

  void handleWarningMessage(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            child: CustomSnackBar.error(
              message: message,
            ),
          ),
        ],
      ),
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.red,
    //   ),
    // );
  }

  void handleSuccessMessage(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            child: CustomSnackBar.success(
              message: message,
            ),
          ),
        ],
      ),
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.green,
    //   ),
    // );
  }
}
