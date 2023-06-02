import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/components/navbar.dart';

class UserDashboard extends StatelessWidget {
  UserDashboard({Key? key}) : super(key: key);
  final List<Widget> navItem = [
    TextButton(
        onPressed: () {},
        child: const Text(
          "About",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Products",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Features",
          style: TextStyle(color: Colors.black),
        )),
    TextButton(
        onPressed: () {},
        child: const Text(
          "Contact",
          style: TextStyle(color: Colors.black),
        )),
  ];
  //list of icon for each navItem
  final List<Icon> navIcon = [
    const Icon(Icons.home),
    const Icon(Icons.shopping_cart),
    const Icon(Icons.featured_play_list),
    const Icon(Icons.contact_mail),
  ];
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
                  contentPadding: const EdgeInsets.only(right: 150, left: 20),
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
