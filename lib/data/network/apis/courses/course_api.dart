import 'dart:convert';

import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/models/courses/course.dart';
import 'package:redesprou_boilerplate_name/utils/credential_utils.dart';
import 'package:redesprou_boilerplate_name/utils/error_utils.dart';
import 'package:redesprou_boilerplate_name/utils/message_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CourseApi {
  Future<void> saveCourse(Course course) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.courses);
      Map<String, String> headers = await getHeaders();
      Response response = await http.post(uri, body: course.toJson(), headers: headers);
      response.statusCode == 200 ? showSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }

  Future<void> updateCourse({required int courseId, required Course course}) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.updateCourse(courseId));
      Map<String, String> headers = await getHeaders();
      Response response = await http.put(uri, body: course.toJson(), headers: headers);
      response.statusCode == 200 ? showSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }

  Future<void> deleteCourse(int courseId) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.updateCourse(courseId));
      Map<String, String> headers = await getHeaders();
      Response response = await http.delete(uri, headers: headers);
      response.statusCode == 200 ? showDeleteSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }
}
