import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_url.dart' as api;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
Future<bool> isLoggedIn({bool autoLogin = false}) async {
  String? value = await storage.read(key: "token");

  // If it is used to determine auto login, check for username and password
  if (autoLogin) {
    value = await storage.read(key: "username");
    value = await storage.read(key: "password");
  }

  if (value != null) {
    debugPrint("isLoggedIn Function: true");
    return true;
  }
  debugPrint("isLoggedIn Function: false");
  return false;
}

/// Log user out
Future logOut() async {
  await storage.delete(key: 'username');
  await storage.delete(key: 'password');
  await storage.delete(key: 'token');
}

/// Log user in
Future<http.Response> login(final username, final password) {
  var url = '${api.getApiBaseUrl()}/auth/login';

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

/// keep user logged in
Future autoLogin() async {
  // get login info
  var loginInfo = await getLoginInfo();

  // make login info into variables
  var username = loginInfo.keys.first;
  var password = loginInfo[username];

  // Print variables
  debugPrint(username);
  debugPrint(password);

  // login with variables
  var response = await login(username, password);

  // turn response into json and print it
  var jsonResponse = json.decode(response.body);
  debugPrint(jsonResponse["access_token"]);

  // store bearer token
  storeToken(jsonResponse["access_token"]);
}

/// Creates an account with given credentials
Future<http.Response> createAccount(String username, String password) {
  var url = "";
  url = '${api.getBaseUrl()}/api/auth/register';

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
