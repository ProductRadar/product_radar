import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:product_radar/bin/product/product_lib.dart' as product;
import 'package:product_radar/main.dart';
import 'package:product_radar/widget/search.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Used to determine if the app bar is on the search page
  final bool search;

  CustomAppBar({super.key, this.search = false});

  @override
  Size get preferredSize => const Size.fromHeight(81);

  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.0),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 1.0),
                    color: Colors.white),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    // If on the search page use the back button and not drawer
                    search == true
                        ? BackButton(
                            color: Colors.red,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ),
                              );
                            },
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          autofocus: false,
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            performSearch(context, _searchController.text);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            // Add a clear button to the search bar
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            ),
                            // Add a search icon or button to the search bar
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () async {
                                // Perform the search here
                                performSearch(context, _searchController.text);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  performSearch(BuildContext context, String searchText) {
    product.basicSearch(searchText).then((response) {
      // Navigates to search page to display the results
      final asyncSnapshot =
          AsyncSnapshot.withData(ConnectionState.done, response);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Search(snapshot: asyncSnapshot),
        ),
      );
    });
  }
}
