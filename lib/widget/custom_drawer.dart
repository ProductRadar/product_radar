import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
        child: Drawer(
            child: ListView(
              children: const <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.login,
                    color: Colors.red,
                  ),
                  title: Text("Login"),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  title: Text("About Us"),
                ),
              ],
            ),
        ),
    );
  }
}

