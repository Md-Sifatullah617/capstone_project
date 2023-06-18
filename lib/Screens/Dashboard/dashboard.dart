import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navbar.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("medicines")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Connection Error"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  var docList = snapshot.data!.docs;
                  print("docList: $docList.length");

                  var halfLength = docList.length ~/ 2;
                  var firstHalf = docList.sublist(0, halfLength);
                  var secondHalf = docList.sublist(halfLength);

                  return SingleChildScrollView(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (var doc in firstHalf)
                                _buildMedicineCard(doc),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (var doc in secondHalf)
                                _buildMedicineCard(doc),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Text("No data");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(QueryDocumentSnapshot doc) {
    var docData = doc.data() as Map<String, dynamic>?;

    // Access the fields and provide a default value if they are nullable
    var slug = docData?['slug'] ?? '';
    var dosageForm = docData?['dosage form'] ?? '';
    var generic = docData?['generic'] ?? '';
    var brandName = docData?['brand name'] ?? '';
    var manufacturer = docData?['manufacturer'] ?? '';
    var packageContainer = docData?['package container'] ?? '';

    return Card(
      child: ListTile(
        title: Text(slug),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dosageForm),
            Text(generic),
            Text(brandName),
            Text(manufacturer),
            Text(packageContainer),
          ],
        ),
      ),
    );
  }
}
