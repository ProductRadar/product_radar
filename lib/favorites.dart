import 'package:flutter/material.dart';
import 'package:product_radar/widget/custom_appbar.dart';
import 'package:product_radar/widget/custom_drawer.dart';
import 'package:product_radar/widget/favorite_products.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const FavoriteProducts(),
      drawer: CustomDrawer(),
    );
  }
}
