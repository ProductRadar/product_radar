import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_radar/widget/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String email = "";

  void launchMailClient() async {
    var mailUrl = Uri(
        scheme: 'mailto',
        path: email,
        query: "subject=Question&body=To Product Radar");
    try {
      await launchUrl(mailUrl);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: email)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email address copied to clipboard")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("About Us"),
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Icon(
                Icons.radar,
                color: Colors.red,
                size: 200.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  "We're a company dedicatd to give the public the tools to help them share their experiences with the products they buy. "
                  "Perspiciatis numquam ea corporis atque sequi quo ex. Voluptatum non similique eos. Sit aperiam doloremque nobis aut. "
                  "Perspiciatis numquam ea corporis atque sequi quo ex. Voluptatum non similique eos. Sit aperiam doloremque nobis aut. "
                  "Perspiciatis numquam ea corporis atque sequi quo ex. Voluptatum non similique eos. Sit aperiam doloremque nobis aut. "),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: RichText(
                    text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    const TextSpan(
                        text:
                            'If you have any questions or would like to report a bug please mail us at '),
                    TextSpan(
                      text: 'support@product_radar.com',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          email = "support@product_radar.com";
                          launchMailClient();
                        },
                    ),
                  ],
                )),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
