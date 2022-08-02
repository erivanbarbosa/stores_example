import 'dart:convert';

import 'package:redesprou_boilerplate_name/utils/message_utils.dart';

Future<T> tryCatch<T>(Function func) async {
  try {
    return await func();
  } catch (e) {
    showErrorMessage(e.toString());
    throw e;
  }
}

getResponseErroMessage(String responseBody) {
  var body = jsonDecode(responseBody);
  Map message = body['errors'];
  var list = message.values.toList();
  var result = list[0];
  return result;
}
