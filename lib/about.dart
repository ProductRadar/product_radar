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
        queryParameters: {"subject": "idk", "body": "idk"});
    try {
      await launchUrl(mailUrl as Uri);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: email)).then((_){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email address copied to clipboard")));
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Mail us at "),
                  GestureDetector(
                    onTap: () {
                      email = "idk@idk.idk";
                      launchMailClient();
                    },
                    child: const Text("idk@idk.idk", style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
