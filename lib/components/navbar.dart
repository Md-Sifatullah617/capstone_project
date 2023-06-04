import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/responsive.dart';

import '../Screens/Dashboard/profile.dart';
import '../Screens/Dashboard/request_med.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //list off user data
  List<String> userData = [];

  List<Widget> navItem = [];
  List<Icon> navIcon = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      String? type = snapshot.data()?['userTypes'];
      //name and email and phone
      String? name = snapshot.data()?['name'];
      String? email = snapshot.data()?['email'];
      String? phone = snapshot.data()?['phone'];
      userData.add(name!);
      userData.add(email!);
      userData.add(phone!);

      if (type != null) {
        setState(() {
          print("User type: $type");
          print("User data: $userData");
          initializeNavItems(
              type); // Call the function to initialize navItem list
        });
      }
    }
  }

  void initializeNavItems(String userType) {
    navItem = [
      Builder(
        builder: (context) => TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => UserDashboard())),
            );
          },
          child: const Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Builder(
        builder: (context) => TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ProfileSection(
                        userData: userData,
                      ))),
            );
          },
          child: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Builder(
        builder: (context) => Visibility(
          visible: userType == 'NGO', // Show only for NGO user
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => const RequestMed())),
              );
            },
            child: const Text(
              "Request Medicine",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      Builder(
        builder: (context) => Visibility(
          visible: userType == 'Donor', // Show only for DONOR user
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => UserDashboard())),
              );
            },
            child: const Text(
              "Sent Medicine",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ];

    navIcon = [
      const Icon(Icons.home),
      const Icon(Icons.account_circle),
      const Icon(Icons.medical_services),
      const Icon(Icons.medical_services_outlined),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child: btnNice()),
            )
          ],
        ),
      ),
      body: Container(
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
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFFC86DD7),
                              Color(0xFF3023AE),
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft)),
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
                  ...navItem,
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
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.black)),
          ],
        ),
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
