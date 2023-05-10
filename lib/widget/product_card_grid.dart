import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_radar/widget/product_details.dart';

class ProductCardGrid extends StatelessWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;

  const ProductCardGrid({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    // Creates a grid to hold the products
    return GridView.builder(
      itemCount: snapshot.data?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      // Utilizes itemBuilder to ensure all the card are the same design/layout
      itemBuilder: (context, index) {
        return GestureDetector(
          // Goes to the product description page.
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetail(id: snapshot.data?[index]["product"]["id"]),
              ),
            );
          },
          child: Card(
            child: Container(
              height: 500,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        // The product image, with an error builder, to ensure there is always something displayed.
                        child: Image.network(
                          snapshot.data?[index]["product"]["image"],
                          fit: BoxFit.contain,
                          // While loading the image display a circle progress indicator
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
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
                      // The name of the product
                      Text(
                        snapshot.data?[index]["product"]["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // The current average rating
                      RatingBarIndicator(
                        rating: double.parse(
                            snapshot.data?[index]["product"]["rating"]),
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 25.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
