class BaseUrl {
  static String baseUrl = "https://churnapi.clanonline.in";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiEndpoints {
  // User
  static String signIn = '/sign_in';
  static String forgotPasword = '/forgot_password_email';
  static String resetPassword = '/reset_password';
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
  static String updateProjectName = "/project/update";
  static String projectInputHistory = "/project/project_input_history";

  // Input
  static String getInputExcelSummary = "/input/get_input_excel_summary";
  static String generateMarts = "/input/generate_marts";
  static String getErrorReport = "/input/get_error_report_for_input";

  // reports
  static String getReportData = "/reports/get_report_data";
}
