// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
  Future<List<Project>?> getAllProjectDetails(
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
        List<Project> listOfProjects = projectFromJson(response.body);
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

// To upload project details
  Future<Project?> updateProjectDetails(
      {required String projectId,
      required ProjectDetails projectDetails}) async {
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
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateProjectDetails}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode({
            "project_id": projectId,
            "project_details": projectDetails.toJson()
          }));

      print(json.encode({
        "project_id": projectId,
        "project_details": projectDetails.toJson()
      }));
      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        Project project = Project.fromJson(json.decode(response.body));

        log("Updated project:..... $project");
        return project;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error ${response}');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

// To get specific project details
  Future<Project?> getProjectDetails({required String projectId}) async {
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
          Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getProjectDetails}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authCredentials.accessToken}',
          },
          body: json.encode({
            "project_id": projectId,
          }));
      print("get project:..... $response");
      // Handle API response
      if (response.statusCode == 200) {
        // final List<Map<String, dynamic>> data = json.decode(response.body);
        Project project = Project.fromJson(json.decode(response.body));

        print("get project:..... ${response.body}");
        print("get project:..... $project");
        return project;
      } else {
        log('Status Code: ${response.statusCode}');
        if (response.statusCode == 401) {
          log('Unauthorized - Please check your credentials');
        } else if (response.statusCode == 404) {
          log('API endpoint not found');
        } else {
          log('Unexpected Error ${response}');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
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
        Project createdProject = Project.fromJson(json.decode(response.body));

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
  Future<Project?> addColumnsToProject({required List columnsToAdd}) async {
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
          log('Unexpected Error ${response}');
        }
        return null;
      }
    } catch (e) {
      log('Network Error: $e');
      return null;
    }
  }

  Future<Project?> uploadFile(
      {required String projectId,
      required FilePickerResult filePickerResult}) async {
    try {
      final AuthCredentials authCredentials =
          await AuthRepository().getTokens();

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
        // print(projectId);
        // print(response.statusCode);
        print(response.reasonPhrase);
        print(response);
        // print(response.stream);
        if (response.statusCode == 200) {
          String responseString = await response.stream.bytesToString();
          print(responseString);
          Project project = Project.fromJson(json.decode(responseString));
          return project;
        } else {
          print(response.reasonPhrase);
          return null;
        }
      } else {
        print('File picking canceled');
      }
    } catch (e) {
      log('Network Error: $e');
    }
    return null;
  }

  Future<String?> getErrorReportForInput({required String inputId}) async {
    print("......get error report $inputId");
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
        Uri.parse(
            '${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}?input_id=$inputId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      print("${ApiEndpoints.getErrorReport} api response : $response");
      if (response.statusCode == 200) {
        String res = response.body;
        print("${ApiEndpoints.getErrorReport} response : $res");
        return res;
      } else {
        print("${ApiEndpoints.getErrorReport} : ${response.reasonPhrase}");
      }
    } catch (e) {
      log('${ApiEndpoints.getErrorReport}:  Network Error: $e');
    }
    return null;
  }
}
