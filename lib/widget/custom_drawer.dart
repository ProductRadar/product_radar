import 'package:flutter/material.dart';
import 'package:product_radar/bin/api/api_lib.dart' as api;

import '../favorites.dart';
import '../login.dart';
import '../sign_up.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: Drawer(
        child: FutureBuilder<bool>(
          future: api.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If the user is logged in display this listview in drawer
              if (snapshot.data == true) {
                return ListView(children: [
                  ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    title: Text("Favorites"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favorites()),
                      );
                    },
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    title: Text("Ratings"),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.red,
                    ),
                    title: Text("About Us"),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text("Sign Out"),
                    onTap: () async {
                      // Close Drawer
                      Scaffold.of(context).closeDrawer();
                      // Call api log out function
                      await api.logOut();
                    },
                  ),
                ]);
              } else // Else when not logged in, display this listview in drawer
              {
                return ListView(
                  children: [
                    const ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.red,
                      ),
                      title: Text("About Us"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.app_registration,
                        color: Colors.red,
                      ),
                      title: const Text("Sign Up"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.login,
                        color: Colors.red,
                      ),
                      title: const Text("Login"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
