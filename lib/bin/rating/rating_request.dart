import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> fetchRatings() async {
  final token = await api.getToken();


  final response = await http.get(
      Uri.parse('${api.getApiBaseUrl()}/getUserRatings'),
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

Future<Map<String, dynamic>> updateRating(double rating, int productId) async {
  final token = await api.getToken();

  // Prepares the parameter to be send
  final queryParams = {
    'product_id': '$productId',
    'rating': '$rating',
  };

  // Creates url, with parameter
  final uri =
      Uri.https(api.ipAddress, '${api.getApiBase()}/rating/1', queryParams);

  // Sends the put request
  final response = await http.put(uri, headers: {
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
    throw Exception(
        'Failed send rating. Status code: ${response.statusCode} Error: ${response.body}');
  }
}
