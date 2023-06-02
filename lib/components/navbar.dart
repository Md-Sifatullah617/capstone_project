import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/responsive.dart';

import '../Screens/Dashboard/dashboard.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFC86DD7),
                        Color(0xFF3023AE),
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                  child: const Center(
                    child: Text("M",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Med_X", style: TextStyle(fontSize: 26))
            ],
          ),
          if (!Responsive.isMobile(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...UserDashboard().navItem,
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                      await FirebaseAuth.instance.signOut();
                    },
                    child: btnNice())
              ],
            )
          else
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.black)),
        ],
      ),
    );
  }

  Container btnNice() {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFC86DD7), Color(0xFF3023AE)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF6078ea).withOpacity(.3),
                offset: const Offset(0, 8),
                blurRadius: 8)
          ]),
      child: const Material(
        color: Colors.transparent,
        child: Center(
          child: Text("LogOut",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1,
              )),
        ),
      ),
    );
  }
}
