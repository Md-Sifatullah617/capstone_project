import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

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
