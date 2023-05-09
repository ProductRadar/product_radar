import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:product_radar/bin/api/api_lib.dart' as api;

Future<List> fetchRatings() async {
  final token = await api.getToken();

  final response =
  await http.get(Uri.parse('http://10.130.56.28/joen/api/getUserFavorites'),
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

Future<Map<String, dynamic>> fetchProduct(int id) async {
  final response = await http.get(Uri.parse('http://10.130.56.28/joen/api/product/$id'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
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

class LoadProductsByRating extends StatelessWidget {

  const LoadProductsByRating({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: fetchRatings(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              itemCount: snapshot.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: fetchProduct(snapshot.data?[index]["favorite"]["product_id"]),
                    builder: (context, product) {
                      if (product.hasData) {
                        return Card(
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        product.data?["product"]["image"],
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.red,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Whoops!',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      product.data?["product"]["name"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(product.data?["product"]["rating"]),
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) =>
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                    });
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
