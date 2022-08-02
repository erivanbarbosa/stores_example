import 'dart:async';
import 'dart:convert';

import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:http/http.dart' as http;

import 'exceptions/network_exceptions.dart';

class RestClient {
  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = JsonDecoder();

  Map<String, String> get defaultHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path) {
    return http.get(Uri.https(Endpoints.baseUrl, path), headers: defaultHeaders).then(_createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String path, {Map<String, String>? headers, body, encoding}) {
    return http
        .post(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path, {Map<String, String>? headers, body, encoding}) {
    return http
        .put(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path, {Map<String, String>? headers, body, encoding}) {
    return http
        .delete(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic _createResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw NetworkException(message: 'Error fetching data from server', statusCode: statusCode);
    }

    return _decoder.convert(res);
  }
}
