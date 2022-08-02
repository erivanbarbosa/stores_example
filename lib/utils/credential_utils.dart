import 'package:redesprou_boilerplate_name/utils/storage_utils.dart';

Future<Map<String, String>> getHeaders() async {
  StorageUtils storageUtils = StorageUtils();
  String token = await storageUtils.getToken();

  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };
}

Future<Map<String, String>> getBasicHeaders() async {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
}
