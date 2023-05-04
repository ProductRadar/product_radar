import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:product_radar/bin/api/api_lib.dart' as api;
import 'package:product_radar/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String password = "";

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool loginFail = false;
  bool passwordEntered = false;
  bool usernameEntered = false;
  bool allPassed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login and start rating products",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  errorText: loginFail
                                      ? 'Login information is invalid'
                                      : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    usernameEntered =
                                        value.isNotEmpty ? true : false;
                                  });
                                  checkIfAllGood();
                                }),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                errorText: loginFail
                                    ? 'Login information is invalid'
                                    : null,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[400]!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  passwordEntered =
                                      value.isNotEmpty ? true : false;
                                });
                                checkIfAllGood();
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: allPassed
                            ? () async {
                                // Get the entered password and username
                                final password = passwordController.text;
                                final username = usernameController.text;

                                api.login(username, password).then((response) {
                                  // Maps the JSON data
                                  Map<String, dynamic> parsed =
                                      jsonDecode(response.body);

                                  debugPrint(response.body);

                                  // If the parsed data has the access token key
                                  if (parsed['access_token'] != null) {
                                    // make login fail false
                                    loginFail = false;

                                    debugPrint("true");
                                    // Uses API library to store token
                                    api.storeToken(parsed['access_token']);
                                    // Uses the API library to store the login info
                                    api.storeLoginInfo(username, password);

                                    // unfocus the textfield
                                    FocusScope.of(context).unfocus();

                                    // Navigate
                                    Navigator.pop(context);
                                  } else {
                                    // Clear password
                                    passwordController.clear();

                                    // make login fail true;
                                    loginFail = true;

                                    // unfocus the textfield
                                    FocusScope.of(context).unfocus();
                                  }
                                });
                              }
                            : null,
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          api.isLoggedIn();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkIfAllGood() {
    if (passwordEntered && usernameEntered) {
      setState(() {
        allPassed = true;
      });
    } else {
      setState(() {
        allPassed = false;
      });
    }
    debugPrint(allPassed.toString());
  }

}
