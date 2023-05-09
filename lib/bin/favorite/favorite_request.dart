import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> fetchFavorites() async {
  final token = await api.getToken();

  final response = await http.get(
      Uri.parse('http://10.130.56.28/joen/api/getUserFavorites'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });

  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to load album');
  }
}
