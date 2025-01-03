class BaseUrl {
  // test url // lense.clanonline.in
  // static String baseUrl = "https://churnapi.clanonline.in";
  //....
  // static String baseUrl = "https://churntesting.clanonline.in";
  //....
  // static String baseUrl = "http://192.168.137.1/";

  // staging url // lense.clanonline.in // myapptest-c1cb6
  // static String baseUrl = "https://churn-staging-120996668109.asia-south1.run.app";

  // Shashank Paisa // production gcp // lense.quantapeoplwe.com // clanchurn
  static String baseUrl = "https://churn-120996668109.asia-south1.run.app";

  // Krishna Paisa //production lambda
  // static String baseUrl =
  //     "https://r3gswwmrfrkssko3e3wz6zfpce0hzlqt.lambda-url.ap-south-1.on.aws/";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiEndpoints {
  // default
  static String signIn = '/sign_in';
  static String forgotPasword = '/forgot_password_email';
  static String resetPassword = '/reset_password';
  static String uploadLogo = '/upload_picture';

  // master data
  static String updateErrorGlossary = '/master_data/update_error_glossary';
  static String downloadErrorGlossary = '/master_data/download_error_glossary';

  // User
  static String getUserDetails = '/user/get_user_details';
  static String addUser = '/user/add';
  static String updateUser = '/user/update';
  static String updateUserStatus = '/user/update_user_status';
  // static String uploadUserPic = '/user/upload_user_pic';
  static String getUserTypes = '/user/get_user_types';
  static String deleteUser = '/user/delete_user';
  static String getAllUsers = '/user/get_all_users';

  // client
  static String clientsList = '/client/client_list';
  static String clientCreate = '/client/create';
  static String clientUpdate = '/client/update';
  static String deleteClient = '/client/delete_client';
  static String getClient = '/client/get_client_details';

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
  static String archiveProject = '/project/archive_project';
  static String getProThrDtls = "/project/get_poject_threshold_details";
  static String updateProThrVals = "/project/add_update_threshold_value";

  // Input
  static String getInputExcelSummary = "/input/get_input_excel_summary";
  static String generateMarts = "/input/generate_marts";
  static String getErrorReport = "/input/get_error_report_for_input";

  // reports
  static String getReportData = "/reports/get_report_data";
  static String getAllReports = "/reports/get_all_reports";
  static String downloadReport = "/reports/generate_excel";
}
