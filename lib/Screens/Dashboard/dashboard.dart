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

    final titles = html
        .querySelectorAll(
            "#ms-block > section > div > div:nth-child(2) > div:nth-child(1) > a:nth-child(1) > div")
        .map((elements) => elements.innerHtml.trim())
        .toList();
    print("Count: ${titles.length}");
    for (final title in titles) {
      print("Titles: $title");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        NavBar(),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: const Center(
            child: Text(
              "Welcome to Med_X",
              style: TextStyle(fontSize: 30),
            ),
          ),
        )
      ]),
    );
  }
}
