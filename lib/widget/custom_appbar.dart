import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          //color set to transperent or set your own color
          statusBarIconBrightness: Brightness.dark,
          //set brightness for icons, like dark background light icons
        )
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SizedBox(
        height: 95.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: 55.0,
            ),
            Positioned(
              top: 30.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(95.0);
}
