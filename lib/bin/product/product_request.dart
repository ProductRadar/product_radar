import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List> fetchProducts() async {
  final response = await http.get(Uri.parse('http://10.130.56.28/api/product'));

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
      await http.get(Uri.parse('http://10.130.56.28/api/product/$id'));

  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    debugPrint(response.body);
    // return response as json
    return json.decode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to get the product with id: $id');
  }
}
