import 'package:flutter/material.dart';
import 'package:product_radar/widget/custom_drawer.dart';
import 'package:product_radar/widget/rated_products.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Ratings"),
        leading: const BackButton(),
      ),
      body: const RatedProducts(),
      drawer: CustomDrawer(),
    );
  }
}
