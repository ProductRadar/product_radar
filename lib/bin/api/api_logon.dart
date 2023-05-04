import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:product_radar/bin/api/api_url.dart';

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
    return true;
  }
  return false;
}

/// Creates an account with given credentials
Future<http.Response> createAccount(String username, String password) {
  var url = "";
    url = '${getBaseUrl()}/api/auth/register';

  // Creates and posts the request.
  return http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
}
