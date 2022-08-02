import 'dart:convert';

import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/data/network/exceptions/network_exceptions.dart';
import 'package:redesprou_boilerplate_name/data/network/rest_client.dart';
import 'package:redesprou_boilerplate_name/firebase_service.dart';
import 'package:redesprou_boilerplate_name/utils/storage_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginApi {
  // rest-client instance
  final RestClient _restClient;

  LoginApi(RestClient this._restClient);

  Future<bool> login(String login, String senha) async {
    final uri = Uri.parse('https://6272912fc455a64564c33f01.mockapi.io/login');
    StorageUtils storageUtils = StorageUtils();
    String body = jsonEncode({'email': login, 'password': senha});

    Response response = await http.post(uri, body: body, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode == 201) {
      //final String res = response.body;
      //Map result = jsonDecode(res);
      //String token = result["token"];
      //storageUtils.storeToken(token);
      //saveFirebaseToken();
      return true;
    } else {
      return false;
    }
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
}
