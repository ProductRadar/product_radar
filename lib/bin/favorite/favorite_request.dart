import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> fetchFavorites() async {
  final token = await api.getToken();

  final response = await http
      .get(Uri.parse('${api.getApiBaseUrl()}/getUserFavorites'), headers: {
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

Future favoriteProduct(int productId, bool isFavorite) async {
  // The api token
  final token = await api.getToken();

  http.Response response;

  String url = '${api.getApiBaseUrl()}/favorite?product_id=$productId';
  var headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };

  if (isFavorite) {
    // Favorite a product
    response = await http.post(
      Uri.parse(url),
      headers: headers,
    );
  } else {
    // Unfavorite a product
    response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );
  }

  // If the server did return a 200 OK response or 201 Created
  if (response.statusCode == 201 || response.statusCode == 200) {
    // return response as json
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception(
        'Failed send favorite. Status code: ${response.statusCode} Error: ${response.body}');
  }
}
