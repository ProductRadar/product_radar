import 'package:flutter/material.dart';
import 'package:product_radar/widget/product_card_grid.dart';

import 'custom_appbar.dart';
import 'custom_drawer.dart';

class Search extends StatefulWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;

  const Search({super.key, required this.snapshot});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Center(child: ProductCardGrid(snapshot: widget.snapshot)),
    );
  }
}
