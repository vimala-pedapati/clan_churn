class BaseUrl {
  static String baseUrl = "https://churnapi.clanonline.in";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiEndpoints {
  static String signIn = '/sign_in';
  static String getUserDetails = '/user/get_user_details';
}
