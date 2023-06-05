import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:flutter_auth/responsive.dart';

class SendMedicine extends StatelessWidget {
  const SendMedicine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 200 : 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Send Medicine",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please fill in the form below to send medicine",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Medicine Name',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Medicine Quantity',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Medicine Expiry Date',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Medicine Description',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
