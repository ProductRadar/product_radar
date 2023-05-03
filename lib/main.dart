import 'package:flutter/material.dart';
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:product_radar/widget/custom_appbar.dart';
import 'package:product_radar/widget/custom_drawer.dart';

Future<List> fetchProducts() async {
  final response =
      await http.get(Uri.parse('http://10.130.56.28/joen/api/product'));

  // If the server did return a 200 OK response
  if (response.statusCode == 200) {
    // return response as json
    return json.decode(response.body)["data"];
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to load album');
  }
}

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHome(),
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
  get orientation => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: [
        ElevatedButton(
          onPressed: () async {
            Map<String, String> val = await api.getLoginInfo();
            debugPrint("${val.keys.first} and ${val.values.first}");
          },
          child: const Text("Test storage"),
        ),
      ]),
      drawer: CustomDrawer(),
    );
  }
}
