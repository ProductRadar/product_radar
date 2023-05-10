import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<Map<String, dynamic>> getRatedProduct(int productId) async {
  // Get token from storage
  final token = await api.getToken();

  // Create the request
  final response = await http.get(
      Uri.parse('${api.getApiBaseUrl()}/getUserRating/$productId'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });

  // return response as json
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)['data'][0];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to get the product');
  }
}

Future<List> getFavoriteProduct(int productId) async {
  // Get token from storage
  final token = await api.getToken();

  // Create the request
  final response = await http.get(
      Uri.parse('${api.getApiBaseUrl()}/getUserFavorite/$productId'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });

  // return response as json
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)['data'];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to get the product');
  }
}
