class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://webapp.gigwks.com.br";

  static const int receiveTimeout = 15000;

  static const int connectionTimeout = 30000;

  static const String getPosts = baseUrl + "/posts";

  static const String doLogin = "/api/authenticate";

  static const String courses = "$baseUrl/api/courses";

  static const String categories = "$baseUrl/api/services/categories";

  static const String services = "$baseUrl/api/services";

  static String cities(int stateId) {
    return "$baseUrl/api/states/$stateId/cities";
  }

  static String states() {
    return "$baseUrl/api/states";
  }

  static String serviceMedia(int serviceId) {
    return "$baseUrl/api/services/$serviceId/media";
  }

  static String deleteMedia({required int serviceId, required int mediaId}) {
    return "$baseUrl/api/services/$serviceId/media/$mediaId";
  }

  static String updateService(int serviceId) {
    return "$baseUrl/api/services/$serviceId";
  }

  static String deleteService(int serviceId) {
    return "$baseUrl/api/services/$serviceId";
  }

  static String findService(int serviceId) {
    return "$baseUrl/api/services/$serviceId";
  }

  static const String createProfile = "$baseUrl/api/signup";

  static const String notifications = "$baseUrl/api/notifications";

  static const String token = "$baseUrl/api/profile/push-token";

  static String updateCourse(int courseId) {
    return "$baseUrl/api/courses/$courseId";
  }

  static const String insurance = "$baseUrl/api/partners-services/wiz/insurance";

  static const String credit = "$baseUrl/api/partners-services/wiz/credit";
}
