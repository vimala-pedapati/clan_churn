// // // ignore_for_file: public_member_api_docs, sort_constructors_first
// // import 'dart:convert';
// // import 'dart:developer';

// // import 'package:clan_churn/api_repos/models/column_model.dart';
// // import 'package:clan_churn/api_repos/models/project_model.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:http_parser/http_parser.dart';

// // import 'package:clan_churn/api_repos/auth_repo.dart';
// // import 'package:clan_churn/api_repos/models/user_model.dart';
// // import 'package:clan_churn/utils/api_endpoins.dart';

// // class ApiRepository {
// //   // To fetch user details
// //   Future<User?> getUserDetails() async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       final http.Response response = await http.get(
// //         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer ${authCredentials.accessToken}',
// //         },
// //       );

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> data = json.decode(response.body);
// //         User user = User.fromJson(data);
// //         log("getUserResponse:..... $data");
// //         return user;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// //   // To fetch clients list
// //   Future<List<ClientDetails>?> getClientsList() async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       final http.Response response = await http.get(
// //         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientsList}"),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer ${authCredentials.accessToken}',
// //         },
// //       );

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         List<ClientDetails> clientDetails =
// //             clientDetailsFromJson(response.body);
// //         log("Clients:..... $clientDetails");
// //         return clientDetails;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // To fetch projects list
// //   Future<List<Project>?> getAllProjectDetails(
// //       {required String clientId}) async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllProjects}"),
// //           headers: {
// //             'Content-Type': 'application/json',
// //             'Authorization': 'Bearer ${authCredentials.accessToken}',
// //           },
// //           body: json.encode({"client_id": clientId}));

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         List<Project> listOfProjects = projectFromJson(response.body);
// //         for (var i in json.decode(response.body)) {
// //           log("project: $i");
// //         }
// //         log("List of Projects:..... $listOfProjects");
// //         return listOfProjects;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // To upload project details
// //   Future<Project?> updateProjectDetails(
// //       {required String projectId,
// //       required ProjectDetails projectDetails}) async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateProjectDetails}"),
// //           headers: {
// //             'Content-Type': 'application/json',
// //             'Authorization': 'Bearer ${authCredentials.accessToken}',
// //           },
// //           body: json.encode({
// //             "project_id": projectId,
// //             "project_details": projectDetails.toJson()
// //           }));

// //       log(json.encode({
// //         "project_id": projectId,
// //         "project_details": projectDetails.toJson()
// //       }));
// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         Project project = Project.fromJson(json.decode(response.body));

// //         log("Updated project:..... $project");
// //         return project;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error ${response}');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // To get specific project details
// //   Future<Project?> getProjectDetails({required String projectId}) async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getProjectDetails}"),
// //           headers: {
// //             'Content-Type': 'application/json',
// //             'Authorization': 'Bearer ${authCredentials.accessToken}',
// //           },
// //           body: json.encode({
// //             "project_id": projectId,
// //           }));
// //       log("get project:..... $response");
// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         Project project = Project.fromJson(json.decode(response.body));

// //         log("get project:..... ${response.body}");
// //         log("get project:..... $project");
// //         return project;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error ${response}');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // To add project
// //   Future<Project?> createProject(
// //       {required String clientId, required String projectName}) async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addProject}"),
// //           headers: {
// //             'Content-Type': 'application/json',
// //             'Authorization': 'Bearer ${authCredentials.accessToken}',
// //           },
// //           body: json.encode({"client_id": clientId, "name": projectName}));

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         Project createdProject = Project.fromJson(json.decode(response.body));

// //         log("Created Project:..... $createdProject");
// //         return createdProject;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // To get all columns
// //   Future<List<ColumnDetails>?> getAllColumns() async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.get(
// //         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllColumns}"),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer ${authCredentials.accessToken}',
// //         },
// //       );

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         // final List<Map<String, dynamic>> data = json.decode(response.body);
// //         List<ColumnDetails> columnsList = columnDetailsFromJson(response.body);
// //         log("List of Columns:..... $columnsList");
// //         return columnsList;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// // // Add columns to project
// //   Future<Project?> addColumnsToProject({required List columnsToAdd}) async {
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addColumnsToProject}"),
// //           headers: {
// //             'Content-Type': 'application/json',
// //             'Authorization': 'Bearer ${authCredentials.accessToken}',
// //           },
// //           body: json.encode(columnsToAdd));

// //       // Handle API response
// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> data = json.decode(response.body);
// //         log(" response: ${response.body}");
// //         Project updatedProjectDetails = Project.fromJson(data);
// //         return updatedProjectDetails;
// //       } else {
// //         log('Status Code: ${response.statusCode}');
// //         if (response.statusCode == 401) {
// //           log('Unauthorized - Please check your credentials');
// //         } else if (response.statusCode == 404) {
// //           log('API endpoint not found');
// //         } else {
// //           log('Unexpected Error $response');
// //         }
// //         return null;
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //       return null;
// //     }
// //   }

// //   Future<Project?> uploadFile(
// //       {required String projectId,
// //       required FilePickerResult filePickerResult}) async {
// //     try {
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       if (filePickerResult.files.isNotEmpty) {
// //         PlatformFile file = filePickerResult.files.first;
// //         var headers = {
// //           'Authorization': 'Bearer ${authCredentials.accessToken}'
// //         };
// //         var request = http.MultipartRequest(
// //           'POST',
// //           Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.uploadFile}'),
// //         );
// //         request.fields.addAll({'project_id': projectId});

// //         if (file.bytes != null) {
// //           request.files.add(http.MultipartFile.fromBytes(
// //             'input_sheet',
// //             file.bytes!,
// //             filename: file.name,
// //           ));
// //         }
// //         request.headers.addAll(headers);
// //         http.StreamedResponse response = await request.send();
// //         // log(projectId);
// //         // log(response.statusCode);
// //         log(response.reasonPhrase);
// //         log(response);
// //         // log(response.stream);
// //         if (response.statusCode == 200) {
// //           String responseString = await response.stream.bytesToString();
// //           log(responseString);
// //           Project project = Project.fromJson(json.decode(responseString));
// //           return project;
// //         } else {
// //           log(response.reasonPhrase);
// //           return null;
// //         }
// //       } else {
// //         log('File picking canceled');
// //       }
// //     } catch (e) {
// //       log('Network Error: $e');
// //     }
// //     return null;
// //   }

// //   Future<String?> getErrorReportForInput({required String inputId}) async {
// //     log("......get error report $inputId");
// //     try {
// //       // Fetch auth credentials
// //       final AuthCredentials authCredentials =
// //           await AuthRepository().getTokens();

// //       // Check if auth credentials are null
// //       if (authCredentials.accessToken.isEmpty) {
// //         log('Access token is empty');
// //         return null;
// //       }

// //       // Make API call with access token
// //       http.Response response = await http.post(
// //         Uri.parse(
// //             '${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}?input_id=$inputId'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer ${authCredentials.accessToken}',
// //         },
// //       );

// //       log("${ApiEndpoints.getErrorReport} api response : $response");
// //       if (response.statusCode == 200) {
// //         String res = response.body;
// //         log("${ApiEndpoints.getErrorReport} response : $res");
// //         return res;
// //       } else {
// //         log("${ApiEndpoints.getErrorReport} : ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       log('${ApiEndpoints.getErrorReport}:  Network Error: $e');
// //     }
// //     return null;
// //   }
// // }

// import 'dart:convert';
// import 'dart:developer';
// import 'package:clan_churn/api_repos/models/column_model.dart';
// import 'package:clan_churn/api_repos/models/project_model.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:clan_churn/api_repos/auth_repo.dart';
// import 'package:clan_churn/api_repos/models/user_model.dart';
// import 'package:clan_churn/utils/api_endpoins.dart';

// class ApiRepository {
//   Future<String?> checkAuth() async {
//     // Fetch auth credentials
//     final AuthCredentials authCredentials = await AuthRepository().getTokens();

//     // Check if auth credentials are null
//     if (authCredentials.accessToken.isEmpty) {
//       log('Access token is empty');
//       return null;
//     } else {
//       return authCredentials.accessToken;
//     }
//   }

//   // Fetch user details
//   Future<User?> getUserDetails() async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       final http.Response response = await http.get(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getUserDetails}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         User user = User.fromJson(data);
//         log("getUserResponse:..... $data");
//         return user;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Fetch clients list
//   Future<List<ClientDetails>?> getClientsList() async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       final http.Response response = await http.get(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.clientsList}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         List<ClientDetails> clientDetails =
//             clientDetailsFromJson(response.body);
//         log("Clients:..... $clientDetails");
//         return clientDetails;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Fetch projects list for a specific client
//   Future<List<Project>?> getAllProjectDetails(
//       {required String clientId}) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllProjects}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//         body: json.encode({"client_id": clientId}),
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         List<Project> listOfProjects = projectFromJson(response.body);
//         log("List of Projects:..... $listOfProjects");
//         return listOfProjects;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Update project details
//   Future<Project?> updateProjectDetails({
//     required String projectId,
//     required ProjectDetails projectDetails,
//   }) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.updateProjectDetails}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//         body: json.encode({
//           "project_id": projectId,
//           "project_details": projectDetails.toJson()
//         }),
//       );

//       log(json.encode({
//         "project_id": projectId,
//         "project_details": projectDetails.toJson()
//       }));

//       // Handle API response
//       if (response.statusCode == 200) {
//         Project project = Project.fromJson(json.decode(response.body));
//         log("Updated project:..... $project");
//         return project;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error ${response}');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Get specific project details
//   Future<Project?> getProjectDetails({required String projectId}) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getProjectDetails}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//         body: json.encode({
//           "project_id": projectId,
//         }),
//       );

//       log("get project:..... $response");

//       // Handle API response
//       if (response.statusCode == 200) {
//         Project project = Project.fromJson(json.decode(response.body));
//         log("get project:..... ${response.body}");
//         log("get project:..... $project");
//         return project;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error ${response}');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Create a new project
//   Future<Project?> createProject({
//     required String clientId,
//     required String projectName,
//   }) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addProject}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//         body: json.encode({"client_id": clientId, "name": projectName}),
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         Project createdProject = Project.fromJson(json.decode(response.body));
//         log("Created Project:..... $createdProject");
//         return createdProject;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Get all columns
//   Future<List<ColumnDetails>?> getAllColumns() async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.get(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.getAllColumns}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         List<ColumnDetails> columnsList = columnDetailsFromJson(response.body);
//         log("List of Columns:..... $columnsList");
//         return columnsList;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Add columns to a project
//   Future<Project?> addColumnsToProject({required List columnsToAdd}) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}${ApiEndpoints.addColumnsToProject}"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//         body: json.encode(columnsToAdd),
//       );

//       // Handle API response
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         log("response: ${response.body}");
//         Project updatedProjectDetails = Project.fromJson(data);
//         return updatedProjectDetails;
//       } else {
//         log('Status Code: ${response.statusCode}');
//         if (response.statusCode == 401) {
//           log('Unauthorized - Please check your credentials');
//         } else if (response.statusCode == 404) {
//           log('API endpoint not found');
//         } else {
//           log('Unexpected Error $response');
//         }
//         return null;
//       }
//     } catch (e) {
//       log('Network Error: $e');
//       return null;
//     }
//   }

//   // Upload a file for a project
//   Future<Project?> uploadFile({
//     required String projectId,
//     required FilePickerResult filePickerResult,
//   }) async {
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       if (filePickerResult.files.isNotEmpty) {
//         PlatformFile file = filePickerResult.files.first;
//         var headers = {
//           'Authorization': 'Bearer ${authCredentials.accessToken}'
//         };
//         var request = http.MultipartRequest(
//           'POST',
//           Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.uploadFile}'),
//         );
//         request.fields.addAll({'project_id': projectId});

//         if (file.bytes != null) {
//           request.files.add(http.MultipartFile.fromBytes(
//             'input_sheet',
//             file.bytes!,
//             filename: file.name,
//           ));
//         }
//         request.headers.addAll(headers);
//         http.StreamedResponse response = await request.send();
//         log(response.reasonPhrase ?? 'No Reason Phrase');
//         if (response.statusCode == 200) {
//           String responseString = await response.stream.bytesToString();
//           log(responseString);
//           Project project = Project.fromJson(json.decode(responseString));
//           return project;
//         } else {
//           log(response.reasonPhrase ?? 'No Reason Phrase');
//           return null;
//         }
//       } else {
//         log('File picking canceled');
//       }
//     } catch (e) {
//       log('Network Error: $e');
//     }
//     return null;
//   }

//   // Get error report for a specific input
//   Future<String?> getErrorReportForInput({required String inputId}) async {
//     log("......get error report $inputId");
//     try {
//       // Fetch auth credentials
//       final AuthCredentials authCredentials =
//           await AuthRepository().getTokens();

//       // Check if auth credentials are null
//       if (authCredentials.accessToken.isEmpty) {
//         log('Access token is empty');
//         return null;
//       }

//       // Make API call with access token
//       http.Response response = await http.post(
//         Uri.parse(
//             '${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}?input_id=$inputId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${authCredentials.accessToken}',
//         },
//       );

//       log("${ApiEndpoints.getErrorReport} api response : $response");
//       if (response.statusCode == 200) {
//         String res = response.body;
//         log("${ApiEndpoints.getErrorReport} response : $res");
//         return res;
//       } else {
//         log("${ApiEndpoints.getErrorReport} : ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       log('${ApiEndpoints.getErrorReport}:  Network Error: $e');
//     }
//     return null;
//   }

// Future<Project?> updateProjectName({
//   required WarningMessageCallback onErrorCallback,
//   required String updatedProjectName,
//   required String projectId,
// }) async {
//   try {
//     // Fetch auth credentials
//     final AuthCredentials authCredentials = await AuthRepository().getTokens();

//     // Check if auth credentials are null
//     if (authCredentials.accessToken.isEmpty) {
//       log('Access token is empty');
//       return null;
//     }

//     // Make API call with access token
//     http.Response response = await http.post(
//       Uri.parse('${BaseUrl.baseUrl}${ApiEndpoints.updateProjectName}'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${authCredentials.accessToken}',
//       },
//       body: json.encode({
//         "project_id": projectId,
//         "name": "simple10",
//         // "name": updatedProjectName,
//       }),
//     );

//     // Handle API response
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       log("Response: ${response.body}");
//       Project updatedProjectDetails = Project.fromJson(data);
//       return updatedProjectDetails;
//     } else {
//       log('Status Code: ${response.statusCode}');
//       if (response.statusCode == 401) {
//         log('Unauthorized - Please check your credentials');
//       } else if (response.statusCode == 404) {
//         log('API endpoint not found');
//       } else if (response.statusCode == 422) {
//         log('Invalid format - Status Code: 422');
//         onErrorCallback('Invalid format. Please check your input and try again.${response.reasonPhrase}');

//       }else {
//         log('Unexpected Error: $response');
//       }
//       return null;
//     }
//   } catch (e) {
//     log("updateProjectName exception: $e");
//     return null;
//   }
// }

// }

// typedef WarningMessageCallback = void Function(String message);

import 'dart:convert';
import 'dart:developer';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/api_endpoins.dart';

typedef OnErrorCallback = void Function(String errorMessage, int errorCode);
typedef OnSuccessCallback = void Function(String message);

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
        _handleStatusCode(  response.statusCode, response.reasonPhrase, onErrorCallback);
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
        log("Clients:..... $clientDetails");
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
  Future<String?> getErrorReportForInput(
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
        Uri.parse(
            '${BaseUrl.baseUrl}${ApiEndpoints.getErrorReport}?input_id=$inputId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authCredentials.accessToken}',
        },
      );

      log("${ApiEndpoints.getErrorReport} api response : $response");
      if (response.statusCode == 200) {
        String res = response.body;
        log("${ApiEndpoints.getErrorReport} response : $res");
        onSuccessCallback(res);
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
        onSuccessCallback("$response");
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
        onSuccessCallback("$response");
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
          onSuccessCallback(responseString);
          return project;
        } else {
          _handleStatusCode( response.statusCode, response.reasonPhrase, onErrorCallback);
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
            'Invalid format. Please check your input and try again.: $reasonPhrase', 422);
        break;
      case 500:
        onErrorCallback('Internal server error: $reasonPhrase', 500);
        break;
      default:
        onErrorCallback('Unexpected error: $reasonPhrase', 0);
    }
  }

  void handleWarningMessage(String message, BuildContext context, int errorCode) {
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
