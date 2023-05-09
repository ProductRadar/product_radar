import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_radar/bin/product/product_lib.dart' as product;
import 'package:product_radar/bin/rating/rating_lib.dart' as rating;
import 'package:product_radar/widget/product_details.dart';

class RatedProducts extends StatelessWidget {
  const RatedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: rating.fetchRatings(),
      builder: (context, snapshot) {
        // if fetch ratings has data
        if (snapshot.hasData) {
          // return a gridview builder
          return GridView.builder(
              // with item count equal to fetch rating data length
              itemCount: snapshot.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                    // get product using fetch ratings product id
                    future: product.getProduct(
                        snapshot.data?[index]["rating"]["product_id"]),
                    builder: (context, product) {
                      // if product has data
                      if (product.hasData) {
                        // a gesture detector to react when card is tapped
                        return GestureDetector(
                            // on tap navigate to product detail page
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      id: snapshot.data?[index]["rating"]
                                          ["product_id"]),
                                ),
                              );
                            },
                            // child card that holds product details
                            child: Card(
                              child: Container(
                                height: 500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // product image
                                        Expanded(
                                          child: Image.network(
                                            product.data?["product"]["image"],
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.red,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Whoops!',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // product name
                                        Text(
                                          product.data?["product"]["name"],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // Product rating
                                        RatingBarIndicator(
                                          rating: double.parse(snapshot
                                              .data?[index]["rating"]["rating"]),
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemSize: 25.0,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
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
                            ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    });
              });
        } else if (snapshot.hasError) {
          // if fetch favorites returns error return error text
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
