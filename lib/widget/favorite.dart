import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:product_radar/bin/user/user_lib.dart' as user;

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
              // There is only data if it is favorite
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return FavoriteButton(
                  valueChanged: () => null,
                  isFavorite: true,
                );
              } else {
                return FavoriteButton(
                  valueChanged: () => null,
                  isFavorite: false,
                );
              }
            }),
          );
        } else {
          return const Spacer();
        }
      }),
    );
  }
}
