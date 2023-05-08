import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:product_radar/bin/api/api_lib.dart' as api;

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: api.isLoggedIn(),
      builder: ((context, snapshot) {
        if (snapshot.data == true) {
          return FavoriteButton(valueChanged: () => null);
        } else {
          return const Spacer();
        }
      }),
    );
  }
}
