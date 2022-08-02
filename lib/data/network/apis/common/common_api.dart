import 'dart:convert';

import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/utils/credential_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CommonApi {
  Future<List<IdAndName>> findCities({stateId}) async {
    final uri = Uri.parse(Endpoints.cities(stateId));
    Map<String, String> headers = await getHeaders();
    Response response = await http.get(uri, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      List data = result['data'];
      var cities = data.map((x) => IdAndName.fromMap(x)).toList();
      return cities;
    } else {
      throw "erro";
    }
  }

  Future<List<IdAndName>> findStates() async {
    final uri = Uri.parse(Endpoints.states());
    Map<String, String> headers = await getHeaders();
    Response response = await http.get(uri, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      List data = result['data'];
      var states = data.map((x) => IdAndName.fromMap(x)).toList();
      return states;
    } else {
      throw "erro";
    }
  }

  Future<void> saveToken(String token) async {
    final uri = Uri.parse(Endpoints.token);
    Map<String, String> headers = await getHeaders();
    Response response = await http.put(uri, body: jsonEncode({"token": token}), headers: headers);
    if (response.statusCode != 200) throw "erro";
  }
}
