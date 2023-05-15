import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_radar/widget/custom_appbar.dart';
import 'package:product_radar/widget/custom_drawer.dart';
import 'package:product_radar/bin/product/product_lib.dart' as product;
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:product_radar/widget/product_card_grid.dart';

import 'package:product_radar/bin/dev_http_overrides.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = DevHttpOverrides();
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  get orientation => null;
  late Timer timer;

  autoLoginCheck() async {
    if (await api.isLoggedIn(autoLogin: true)) {
      await api.autoLogin();
    }
  }

  void autoLoginCounter() {
    // every hour check if logged in and then refresh bearer token

    Timer.periodic(const Duration(seconds: 3600), (timer) async {
      setState(() {
        autoLoginCheck();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    autoLoginCheck();
    autoLoginCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Center(
        child: FutureBuilder<List>(
          future: product.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProductCardGrid(snapshot: snapshot);
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
