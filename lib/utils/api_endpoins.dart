class BaseUrl {
  static String baseUrl = "https://churnapi.clanonline.in";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiEndpoints {

  // User 
  static String signIn = '/sign_in';
  static String getUserDetails = '/user/get_user_details';

  // client
  static String clientsList = '/client/client_list';

  // Project 
  static String getAllProjects = '/project/get_all_projects';
  static String addProject = '/project/add';
  static String getAllColumns = '/project/get_all_columns';
  static String addColumnsToProject = '/project/column_to_project';
  static String updateProjectDetails = "/project/update_project_details";
  static String getProjectDetails = "/project/get_project";
  static String uploadFile = "/project/upload_input_data";
  static String getErrorReport = "/project/get_error_report_for_input";
  static String updateProjectName = "/project/update";
  static String getInputExcelSummary = "/project/get_input_excel_summary";
}
