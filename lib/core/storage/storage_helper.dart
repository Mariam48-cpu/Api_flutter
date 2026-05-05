import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: "access-token", value: token);
  }

static Future<String?> getToken() async {
   return await _storage.read(key: "access-token");
  }

 static Future<void> deletToken() async {
    await _storage.delete(key: "access-token");
  }
}
