import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_radar/bin/user/user_lib.dart' as user;
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:product_radar/bin/product/product_lib.dart' as product;

class Rate extends StatefulWidget {
  final int id;

  const Rate({super.key, required this.id});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: api.isLoggedIn(),
      builder: ((context, snapshot) {
        if (snapshot.data == false) {
          return FutureBuilder(
            future: product.getProductRating(widget.id),
            builder: ((context, snapshot) {
              return RatingBarIndicator(
                rating:
                    double.parse(snapshot.data?['data'][0]["rating"]["rating"]),
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 25.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              );
            }),
          );
        } else {
          return Row(
            children: [
              const Text("Your rating: "),
              FutureBuilder(
                future: user.getFavoriteProduct(widget.id),
                builder: ((context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return RatingBar.builder(
                      initialRating:
                          double.parse(snapshot.data?[0]['rating']['rating']),
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 25.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        if (kDebugMode) {
                          print(rating);
                        }
                      },
                    );
                  } else {
                    return RatingBar.builder(
                      initialRating:
                      double.parse("0"),
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 25.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        if (kDebugMode) {
                          print(rating);
                        }
                      },
                    );
                  }
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}
