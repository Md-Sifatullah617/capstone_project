import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Authentication/auth_services.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard.dart';
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
  String? pickedImagePath;
  Future<List<Uint8List>>? pickedImageBytes; // Update the type
  String medicineName = "";
  String medicineDescription = "";
  String medicineQuantity = "";
  String pickUpLocation = "";

  onSubmitted() async {
    print(
        "$medicineName $medicineDescription $medicineQuantity $pickUpLocation, $pickedImageBytes");
    String uID = FirebaseAuth.instance.currentUser!.uid;
    List<Uint8List>? images = await pickedImageBytes;
    String status = "Sent";
    await FirestoreServices.saveMedicineData(
      medicineName,
      medicineDescription,
      medicineQuantity,
      pickUpLocation,
      uID,
      images,
      status,
    );
    //show a dialog box to show that the medicine has been sent
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Medicine Sent"),
          content: const Text("Your medicine has been sent successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserDashboard()));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImageFile != null) {
      final bytes = await pickedImageFile.readAsBytes(); // Fix this line
      setState(() {
        pickedImage = File(pickedImageFile.path);
        pickedImagePath = pickedImageFile.path;
        pickedImageBytes = Future.value([bytes]);
      });
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );
      if (result != null) {
        final List<PlatformFile> files = result.files;
        final List<Uint8List> bytesList = [];
        for (final file in files) {
          bytesList.add(file.bytes!);
        }
        setState(() {
          pickedImagePath = files[0].name;
          pickedImageBytes = Future.value(bytesList);
        });
      }
    } catch (e) {
      // Handle file picking error
      setState(() {
        pickedImagePath = null;
        pickedImageBytes = null;
      });
      print('File picking error: $e');
    }
  }

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
                                      vertical: defaultPadding,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          medicineName = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Medicine Name",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          medicineDescription = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Medicine Description",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          medicineQuantity = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Quantity",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor: kPrimaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          pickUpLocation = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Pickup Location",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (kIsWeb || Platform.isWindows) {
                                          pickFile();
                                        } else {
                                          pickImage();
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              if (kIsWeb ||
                                                  Platform.isWindows) {
                                                pickFile();
                                              } else {
                                                pickImage();
                                              }
                                            },
                                            initialValue: pickedImagePath ??
                                                'select image', // Update this line
                                            decoration: const InputDecoration(
                                              hintText: "Selected Image",
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            width: double.infinity,
                                            height: pickedImageBytes != null
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4
                                                : 200,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: pickedImageBytes != null
                                                  ? FutureBuilder<
                                                      List<Uint8List>>(
                                                      future: pickedImageBytes,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const CircularProgressIndicator();
                                                        }
                                                        if (snapshot.hasData &&
                                                            snapshot.data !=
                                                                null) {
                                                          return ListView
                                                              .builder(
                                                            itemCount: snapshot
                                                                .data!.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final bytes =
                                                                  snapshot.data![
                                                                      index];
                                                              return kIsWeb
                                                                  ? Image
                                                                      .memory(
                                                                      bytes,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image
                                                                      .memory(
                                                                      bytes,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    );
                                                            },
                                                          );
                                                        }
                                                        return const Icon(
                                                          Icons.image_outlined,
                                                          size: 80,
                                                          color: Colors.grey,
                                                        );
                                                      },
                                                    )
                                                  : const Icon(
                                                      Icons.image_outlined,
                                                      size: 80,
                                                      color: Colors.grey,
                                                    ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          onSubmitted();
                                        },
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
                  mobile: mobileResponsive(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileResponsive() {
    return Column(
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
            vertical: defaultPadding,
          ),
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
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding,
          ),
          child: GestureDetector(
            onTap: () {
              if (kIsWeb || Platform.isWindows) {
                pickFile();
              } else {
                pickImage();
              }
            },
            child: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    if (kIsWeb || Platform.isWindows) {
                      pickFile();
                    } else {
                      pickImage();
                    }
                  },
                  initialValue: pickedImagePath ?? '',
                  decoration: const InputDecoration(
                    hintText: "Selected Image",
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: pickedImage != null
                      ? MediaQuery.of(context).size.height * 0.4
                      : 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: pickedImageBytes != null
                        ? FutureBuilder<List<Uint8List>>(
                            future: pickedImageBytes!,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasData && snapshot.data != null) {
                                final imageList = snapshot.data!;
                                return Container(
                                  height:
                                      200, // Set a specific height for the container
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageList.length,
                                    itemBuilder: (context, index) {
                                      final bytes = imageList[index];
                                      return Container(
                                        width:
                                            200, // Set a specific width for the container
                                        child: kIsWeb
                                            ? Image.memory(
                                                bytes,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.memory(
                                                bytes,
                                                fit: BoxFit.cover,
                                              ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return const Icon(
                                Icons.image_outlined,
                                size: 80,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onSubmitted();
              },
              child: const Text("Submit"),
            ),
          ),
        ),
      ],
    );
  }
}
