import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Authentication/auth_services.dart';
import 'package:flutter_auth/Screens/Dashboard/notification_abc.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/components/navbar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestMed extends StatefulWidget {
  const RequestMed({Key? key}) : super(key: key);

  @override
  State<RequestMed> createState() => _RequestMedState();
}

class _RequestMedState extends State<RequestMed> {
  String medicineName = "";

  String medicineDescription = "";

  String medicineQuantity = "";

  String pickUpLocation = "";
  Future<List<Uint8List>>? pickedImageBytes;

  onSubmitted() async {
    print(
        "$medicineName $medicineDescription $medicineQuantity $pickUpLocation, $pickedImageBytes");
    String uID = FirebaseAuth.instance.currentUser!.uid;
    List<Uint8List>? images = await pickedImageBytes;
    String status = "Requested";
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
          title: const Text("Medicine Request"),
          content: const Text("Your medicine has been requested successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
                                "Request Medicine",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Please fill in the form below to request medicine",
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
                                    hintText: "Requested Location",
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
    ]));
  }

  Widget mobileResponsive() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Request Medicine",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Please fill in the form below to request medicine",
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
                hintText: "Requested Location",
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
    );
  }
}
