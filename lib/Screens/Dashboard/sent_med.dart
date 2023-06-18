import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class SendMedicine extends StatefulWidget {
  const SendMedicine({Key? key}) : super(key: key);

  @override
  State<SendMedicine> createState() => _SendMedicineState();
}

class _SendMedicineState extends State<SendMedicine> {
  File? pickedImage;

  Future<void> pickImage() async {
    final XFile? pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageFile != null) {
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });
    }
  }

  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final PlatformFile file = result.files.first;

      setState(() {
        pickedImage = File(file.path!);
      });
    }
  }

  Widget buildImagePreview() {
  if (pickedImage != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        pickedImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  } else {
    return const Icon(
      Icons.image_outlined,
      size: 80,
      color: Colors.grey,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Background(
              child: SingleChildScrollView(
                child: Responsive(
                  desktop: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: SvgPicture.asset("assets/icons/login.svg"),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450,
                              child: Column(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Medicine Name",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Medicine Description",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Medicine Quantity",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (kIsWeb || Platform.isWindows) {
                                          pickFile();
                                        } else {
                                          pickImage();
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: buildImagePreview(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Submit"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  mobile: Column(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          cursorColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            hintText: "Medicine Name",
                          ),
                        ),
                      ),
                      // Add more text fields and UI elements as needed
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
