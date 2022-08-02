import 'dart:convert';
import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/models/notification/notification.dart';
import 'package:redesprou_boilerplate_name/utils/credential_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NotificationApi {
  Future<List<NotificationMessage>> findNotifications() async {
    final uri = Uri.parse(Endpoints.notifications);
    Map<String, String> headers = await getHeaders();
    Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      List data = result['data'];
      var notifications = data.map((x) => NotificationMessage.fromMap(x)).toList();
      return notifications;
    } else {
      throw "erro";
    }
  }
}
