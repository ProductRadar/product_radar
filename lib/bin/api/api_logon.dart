import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create the storage
const storage = FlutterSecureStorage();

/// Store API token
storeToken(String value) async {
  await storage.write(key: "token", value: value);
}

/// Store login information
storeLoginInfo(String username, String password) async {
  await storage.write(key: "username", value: username);
  await storage.write(key: "password", value: password);
}

/// Get token from storage
Future<String> getToken() async {
  String? value = await storage.read(key: "token") ?? "no token";
  return Future.value(value);
}

/// Get login information from storage
Future<Map<String, String>> getLoginInfo() async {
  String? username = await storage.read(key: "username");
  String? password = await storage.read(key: "password");
  return {username!: password!};
}

/// Check if the user is logged in
Future<bool> isLoggedIn() async {
  String? value = await storage.read(key: "token");
  if (value != null) {
    print("isLoggedIn Function: true");
    return true;
  }
  print("isLoggedIn Function: false");
  return false;
}

/// Log user out
Future logOut() async {
  await storage.delete(key: 'username');
  await storage.delete(key: 'password');
  await storage.delete(key: 'token');
}