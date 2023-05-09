import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> fetchProducts() async {
  final response = await http.get(Uri.parse('${api.getApiBaseUrl()}/product'));

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

Future<Map<String, dynamic>> getProduct(int id) async {
  final response =
      await http.get(Uri.parse('${api.getApiBaseUrl()}/product/$id'));
  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to get the product with id: $id');
  }
}

Future<Map<String, dynamic>> getProductRating(int id) async {
  final response = await http
      .get(Uri.parse('${api.getApiBaseUrl()}/rating/getProductRating/$id'));

  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to get the product with id: $id');
  }
}
