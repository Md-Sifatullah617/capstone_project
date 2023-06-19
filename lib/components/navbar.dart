import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/Dashboard/notification_abc.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/responsive.dart';
import '../Screens/Dashboard/profile.dart';
import '../Screens/Dashboard/request_med.dart';
import '../Screens/Dashboard/sent_med.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> userData = [];
  List<Widget> navItem = [];
  List<Icon> navIcon = [];
  String userType = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final userDataMap = snapshot.data() as Map<String, dynamic>?;

      if (userDataMap != null) {
        final type = userDataMap['userTypes'] as String?;
        final name = userDataMap['name'] as String?;
        final email = userDataMap['email'] as String?;
        final phone = userDataMap['phone'] as String?;

        if (type != null && name != null && email != null && phone != null) {
          setState(() {
            userType = type;
            userData.addAll([name, email, phone]);
            initializeNavItems(type);
          });
        }
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
              MaterialPageRoute(builder: (context) => UserDashboard()),
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
                builder: (context) => ProfileSection(userData: userData),
              ),
            );
          },
          child: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      if (userType == 'NGO')
        Builder(
          builder: (context) => TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequestMed()),
              );
            },
            child: const Text(
              "Request Medicine",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      if (userType == 'Donor')
        Builder(
          builder: (context) => TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SendMedicine()),
              );
            },
            child: const Text(
              "Sent Medicine",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      Builder(
        builder: (context) => TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notifications()),
            );
          },
          child: const Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ];

    navIcon = [
      const Icon(Icons.home),
      const Icon(Icons.account_circle),
      if (userType == 'NGO')
        const Icon(Icons.medical_services)
      else
        const Icon(Icons.medical_services_outlined),
      const Icon(Icons.notifications),
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
            ...navItem.map(
              (e) => ListTile(
                contentPadding: const EdgeInsets.only(right: 100, left: 20),
                title: e,
                leading: navIcon[navItem.indexOf(e)],
              ),
            ),
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
                    (route) => false,
                  );
                  await FirebaseAuth.instance.signOut();
                },
                child: btnNice(),
              ),
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
                        colors: [Color(0xFFC86DD7), Color(0xFF3023AE)],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "M",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Med_X",
                  style: TextStyle(fontSize: 26),
                )
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
                        (route) => false,
                      );
                      await FirebaseAuth.instance.signOut();
                    },
                    child: btnNice(),
                  )
                ],
              )
            else
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
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
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6078ea).withOpacity(.3),
            offset: const Offset(0, 8),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Text(
            "LogOut",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
