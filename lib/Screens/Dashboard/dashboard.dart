import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/searchbar.dart';
import 'package:flutter_auth/components/navbar.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavBar(),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //show a banner image with carousel slider
                  _buildCarouselSlider(),
                  SizedBox(
                    height: 20,
                  ),
                  SearchBarWidget(
                    hintText: '',
                    onSearchChanged: (String value) {},
                    textController: _searchController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double carouselWidth = constraints.maxWidth;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: CarouselSlider(
            items: [
              Image.asset(
                "assets/images/WhatsApp Image 2023-06-19 at 12.03.22 AM.jpeg",
                fit: BoxFit.cover,
                width: carouselWidth,
              ),
              Image.asset(
                "assets/images/WhatsApp Image 2023-06-18 at 11.43.31 PM.jpeg",
                fit: BoxFit.cover,
                width: carouselWidth,
              ),
              Image.asset(
                "assets/images/WhatsApp Image 2023-06-18 at 11.43.25 PM.jpeg",
                fit: BoxFit.cover,
                width: carouselWidth,
              ),
            ],
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 16 / 9,
            ),
          ),
        );
      },
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
            if (dosageForm != null) Text(dosageForm),
            if (generic != null) Text(generic),
            if (brandName != null) Text(brandName),
            if (manufacturer != null) Text(manufacturer),
            if (packageContainer != null) Text(packageContainer),
          ],
        ),
      ),
    );
  }
}
