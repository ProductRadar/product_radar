
import 'package:flutter/material.dart';
import 'package:product_radar/sign-up.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('This is my very coll app ☻')),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Card(
            // clipBehavior is necessary because, without it, the InkWell's animation
            // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
            // This comes with a small performance cost, and you should not set [clipBehavior]
            // unless you need it.
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () async {
                debugPrint('Card tapped.');
                // Future<http.Response> fetchAlbum() {
                //   return http.get(Uri.parse('http://10.130.56.36/joen/api/product'));
                // }
                // var response = await fetchAlbum();
                // debugPrint(response.body);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignupPage(),
                ));
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Text('A card that can be tapped'),
              ),
            ),
          );
        }),
      ),
    );
  }
}
