import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    getWebsiteData();
    super.initState();
  }

  Future getWebsiteData() async {
    final url = Uri.parse("https://medex.com.bd/generics");
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    try {
      final titles = html
          .querySelectorAll(
              "#ms-block > section > div > div:nth-child(2) > div:nth-child(1) > a:nth-child(1) > div > div.col-xs-12.data-row-top.dcind-title")
          .map((elements) => elements.innerHtml.trim())
          .toList();
      print("Count: ${titles.length}");
      for (final title in titles) {
        print("Titles: $title");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        NavBar(),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "Welcome to Medex",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "Your one stop solution for all your medical needs",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "We are here to help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "We are here to help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "We are here to help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "We are here to help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                    "We are here to help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
            ],
          )
        )
      ]),
    );
  }
}
