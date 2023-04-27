import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_radar/api_url_lib.dart' as api;

// Create a text controller and use it to retrieve the current value
// of the TextField.
final textController = TextEditingController();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

String password = "";

class _SignupPageState extends State<SignupPage> {
  final TextEditingController passwordController = TextEditingController();

  ///Passing a key to access the validate function
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  bool goodPassword = false;
  bool matchingPassword = false;
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
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create an Account, Its free",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
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
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: "Username",
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
                                    checkIfAllGood();
                                  });
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
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: "Password",
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
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FlutterPwValidator(
                          key: validatorKey,
                          controller: passwordController,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          numericCharCount: 2,
                          specialCharCount: 1,
                          normalCharCount: 3,
                          width: 400,
                          height: 150,
                          onSuccess: () {
                            setState(() {
                              goodPassword = true;
                              checkIfAllGood();
                            });
                          },
                          onFail: () {
                            setState(() {
                              goodPassword = false;
                              checkIfAllGood();
                            });
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: "Confirm password",
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
                                    matchingPassword =
                                        passwordController.text == value;
                                    checkIfAllGood();
                                  });
                                }),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
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
                                createAccount().then((response) {
                                  debugPrint(response.body);
                                  Navigator.pop(context);
                                });
                              }
                            : null,
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          "Sign Up",
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
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
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
    if (goodPassword && matchingPassword && usernameEntered) {
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

  Future<http.Response> createAccount() {
    final password = passwordController.text;
    final username = textController.text;

    return http.post(
      Uri.parse('${api.getBaseUrl()}/duus/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }
}
