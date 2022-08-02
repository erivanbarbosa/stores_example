import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
// Create storage
  final storage = new FlutterSecureStorage();

// Read value
//String value = await storage.read(key: key);

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
//await storage.delete(key: key);

// Delete all
////await storage.deleteAll();

// Write value
//await storage.write(key: key, value: value);

  storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "token") ?? "";
    return token;
  }
}
