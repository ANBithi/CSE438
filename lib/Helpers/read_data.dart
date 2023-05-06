import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Map<String, dynamic>> readUserStorageData() async {
  const storage = FlutterSecureStorage();
  final jsonString = await storage.read(key: 'authData');
  Map<String, dynamic> userData = {};
  if (jsonString != null) {
    userData = json.decode(jsonString);
  }
  return userData;
}

Future<Map<String, String>> authHeader() async {
  // return authorization header with jwt token
  const storage = FlutterSecureStorage();
  final jsonUser = await storage.read(key: 'authData');
  final user = jsonDecode(jsonUser ?? "");
  if (user != "") {
    return {'Authorization': 'Bearer ${user['token']}'};
  } else {
    return {};
  }
}
