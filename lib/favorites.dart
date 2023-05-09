import 'package:flutter/material.dart';
import 'package:product_radar/widget/custom_drawer.dart';
import 'package:product_radar/widget/favorite_products.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Favorites"),
        leading: const BackButton(),
      ),
      body: const FavoriteProducts(),
      drawer: CustomDrawer(),
    );
  }
}
