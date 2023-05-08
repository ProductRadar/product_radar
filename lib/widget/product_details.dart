import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_radar/bin/product/product_lib.dart' as product;
import 'package:product_radar/widget/favorite.dart';
import 'package:product_radar/widget/rating.dart';

class ProductDetail extends StatefulWidget {
  final int id;

  const ProductDetail({super.key, required this.id});

  @override
  ProductDetailState createState() => ProductDetailState();
}

//TODO: Do something to get the data required, maybe by utilizing the init function

class ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: product.getProduct(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Lul(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget Lul(data) {
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
          Card(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.network(
                  data["product"]["image"],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      data['product']['name'],
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 34,
                        color: Color(0xff000000),
                      ),
                    ),
                    Favorite(id: widget.id),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
            width: 16,
          ),
          Card(
            margin: EdgeInsets.all(4.0),
            color: Color(0xffe0e0e0),
            shadowColor: Color(0xff000000),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Rate(id: widget.id),
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
              child: Row(
                children: [
                  const Text(
                    "Description: ",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.normal,
                      fontSize: 24,
                      // color: Color(0xff000000),
                    ),
                  ),
                  Text(
                    data['product']['description'],
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 24,
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

/*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: product.getProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 500,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              snapshot.data?["product"]["image"],
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
                          Row(
                            children: [
                              Text(
                                snapshot.data?["product"]["name"],
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Favorite(id: widget.id),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Rate(id: widget.id),
                    ),
                    Card(
                      child: Row(
                        children: [
                          const Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            snapshot.data?['product']['description'],
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
*/
//}
