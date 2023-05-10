import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> basicSearch(String searchTerm) async {
  final response = await http.get(Uri.parse('${api.getApiBaseUrl()}/search/$searchTerm'));

  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to load the products');
  }
}

