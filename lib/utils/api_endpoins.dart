class BaseUrl {
  static String baseUrl = "https://churnapi.clanonline.in";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiEndpoints {
  static String signIn = '/sign_in';
  static String getUserDetails = '/user/get_user_details';
  static String clientsList = '/client/client_list';
  static String getAllProjects = '/project/get_all_projects';
  static String addProject = '/project/add';
  static String getAllColumns = '/project/get_all_columns';
  static String addColumnsToProject = '/project/column_to_project';
  static String updateProjectDetails = "/project/update_project_details";
}
