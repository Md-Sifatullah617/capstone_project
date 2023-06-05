import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:flutter_auth/constants.dart';

class RequestMed extends StatelessWidget {
  const RequestMed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      NavBar(),
      Container(
        padding: const EdgeInsets.only(top: 20, left: defaultPadding*20, right: defaultPadding*20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Request Medicine",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please fill in the form below to request medicine",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Medicine Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Medicine Quantity',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Medicine Description',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Medicine Price',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ]));
  }
}
