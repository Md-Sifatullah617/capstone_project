import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';

class ProfileSection extends StatefulWidget {
  final List<String> userData;
  const ProfileSection({Key? key, required this.userData}) : super(key: key);

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  Uint8List? _selectedImageBytes;
  ImageProvider? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(140),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 120,
                            backgroundImage: _selectedImage ??
                                const AssetImage(
                                  "assets/images/profile1.png",
                                ),
                          ),
                        ),
                        if (_selectedImageBytes == null)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.userData[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  widget.userData[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  widget.userData[2],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                //location field here and a button to change it if needed
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Location: ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Dhaka, Bangladesh",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
