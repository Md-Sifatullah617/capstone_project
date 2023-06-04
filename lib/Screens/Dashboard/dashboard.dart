import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class UserDashboard extends StatelessWidget {
   UserDashboard({Key? key}) : super(key: key);

  final List<Widget> navItem = [
    TextButton(
        onPressed: () {},
        child: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Request Medicine",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Sent Medicine",
          style: TextStyle(color: Colors.black),
        )),
  ];

  //list of icon for each navItem
  final List<Icon> navIcon = [
    const Icon(Icons.home),
    const Icon(Icons.account_circle),
    const Icon(Icons.medical_services),
    const Icon(Icons.medical_services_outlined),
  ];

  Future getWebsiteData() async {
    final url = Uri.parse("https://medex.com.bd/generics");
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll(
            "#ms-block > section > div > div:nth-child(2) > div:nth-child(1) > a:nth-child(1) > div")
        .map((elements) => elements.innerHtml.trim())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            //show the navItem list with a different prefix icon for each item
            ...navItem.map((e) => ListTile(
                  contentPadding: const EdgeInsets.only(right: 100, left: 20),
                  title: e,
                  leading: navIcon[navItem.indexOf(e)],
                )),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const NavBar().btnNice()),
            )
          ],
        ),
      ),
      body: Stack(children: [
        const NavBar(),
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
