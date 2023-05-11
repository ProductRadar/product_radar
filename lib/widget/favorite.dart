import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:product_radar/bin/user/user_lib.dart' as user;
import 'package:product_radar/bin/favorite/favorite_lib.dart' as favorite;

class Favorite extends StatefulWidget {
  final int id;

  const Favorite({super.key, required this.id});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: api.isLoggedIn(),
      builder: ((context, snapshot) {
        if (snapshot.data == true) {
          return FutureBuilder(
            future: user.getFavoriteProduct(widget.id),
            builder: ((context, snapshot) {
              // Widget to be returned
              Widget favoriteButton = const Spacer();
              // If data is retrieved create the favorite button
              if (snapshot.hasData) {
                favoriteButton = FavoriteButton(
                  valueChanged: (isFavorite) async {
                    await favorite.favoriteProduct(widget.id, isFavorite);
                  },
                  isFavorite:
                      // There is only data if it is favorite
                      (snapshot.data != null && snapshot.data!.isNotEmpty),
                );
              }
              return favoriteButton;
            }),
          );
        } else {
          return const Spacer();
        }
      }),
    );
  }
}
