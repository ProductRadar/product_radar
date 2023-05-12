import 'package:flutter/material.dart';
import 'package:product_radar/bin/product/product_lib.dart' as product;
import 'package:product_radar/widget/favorite.dart';
import 'package:product_radar/widget/rating.dart';

class ProductDetail extends StatefulWidget {
  final int id;

  const ProductDetail({super.key, required this.id});

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: product.getProduct(widget.id),
        builder: (context, snapshot) {
          // The logic
          if (snapshot.hasData) {
            return productDetails(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  /// The widget to be displayed
  Widget productDetails(data) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 8,
            width: 16,
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(4),
              color: const Color(0xffe0e0e0),
              shadowColor: const Color(0xff000000),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Image.network(
                      data["product"]["image"],
                      fit: BoxFit.cover,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          data['product']['name'],
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Favorite(id: widget.id),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
            width: 16,
          ),
          Card(
            margin: const EdgeInsets.all(4.0),
            color: const Color(0xffe0e0e0),
            shadowColor: const Color(0xff000000),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Rate(
                  id: widget.id,
                  rating: double.parse(data['product']['rating']),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
            width: 16,
          ),
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.all(4),
              color: const Color(0xffe0e0e0),
              shadowColor: const Color(0xff000000),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Description: ",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      data['product']['description'],
                      maxLines: 10,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
