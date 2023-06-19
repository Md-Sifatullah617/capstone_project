import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("submittedMedicineData")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Connection Error"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      var docList = snapshot.data!.docs;
                      print("docList: $docList");

                      // Divide the docList into two halves
                      var firstHalf = docList.sublist(0, docList.length ~/ 2);
                      var secondHalf = docList.sublist(docList.length ~/ 2);

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: firstHalf.length,
                              itemBuilder: (context, index) {
                                var doc = firstHalf[index];
                                return MedicineCard(doc: doc);
                              },
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: secondHalf.length,
                              itemBuilder: (context, index) {
                                var doc = secondHalf[index];
                                return MedicineCard(doc: doc);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: Text("No Data Found"),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> doc;

  const MedicineCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //create a container or button with the status of the medicine
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    doc["status"] ?? "No Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Text(
                doc["name"] ?? "No Name",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doc["description"] ?? "No Description",
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doc["quantity"] ?? "No Quantity",
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doc["pickUpLocation"] ?? "No Pickup Location",
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              // Show images of the medicine stored
            ],
          ),
        ),
      ),
    );
  }
}
