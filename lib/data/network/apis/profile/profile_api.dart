import 'dart:convert';

import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/models/profile/create_profile.dart';
import 'package:redesprou_boilerplate_name/models/profile/profile.dart';
import 'package:redesprou_boilerplate_name/utils/credential_utils.dart';
import 'package:redesprou_boilerplate_name/utils/error_utils.dart';
import 'package:redesprou_boilerplate_name/utils/message_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfileApi {
  Future<void> saveProfile(Profile profile) async {
    return tryCatch(() async {
      final uri = Uri.parse('https://webapp.gigwks.com.br/api/profile');
      Map<String, String> headers = await getHeaders();

      Response response = await http.put(uri, body: profile.toJson(), headers: headers);
      response.statusCode == 200 ? showSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }

  Future<Profile> findProfile() async {
    final uri = Uri.parse('https://webapp.gigwks.com.br/api/profile');
    Map<String, String> headers = await getHeaders();
    Response response = await http.get(uri, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      var data = result['data'];
      Profile profile = Profile.fromMap(data);
      return profile;
    } else {
      throw "erro";
    }
  }

  Future<void> addAvatar(String image) async {
    final uri = Uri.parse('https://webapp.gigwks.com.br/api/profile/photo');
    Map<String, String> headers = await getHeaders();
    Map<String, String> body = {"name": "profile-image", "media": "data:image/jpeg;base64,$image"};

    Response response = await http.post(uri, body: jsonEncode(body), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode != 200) {
      throw "Error";
    }
  }

  Future<void> addCover(String image) async {
    final uri = Uri.parse('https://webapp.gigwks.com.br/api/profile/featured-photo');
    Map<String, String> headers = await getHeaders();
    Map<String, String> body = {"name": "profile-cover", "media": "data:image/jpeg;base64,$image"};

    Response response = await http.post(uri, body: jsonEncode(body), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode != 200) {
      throw "Error";
    }
  }

  Future<void> createProfile(CreateProfile profile) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.createProfile);
      Map<String, String> headers = await getBasicHeaders();
      Response response = await http.post(uri, body: profile.toJson(), headers: headers);
      response.statusCode == 200 ? showSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }
}
