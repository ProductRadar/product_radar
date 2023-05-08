import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomBodyLoadProducts extends StatelessWidget {
  final Future<List> products;

  const CustomBodyLoadProducts({super.key, required this.products});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: products,
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
                                snapshot.data?[index]["product"]["image"],
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
                              snapshot.data?[index]["product"]["name"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RatingBarIndicator(
                              rating: double.parse(snapshot.data?[index]
                              ["product"]["rating"]),
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
