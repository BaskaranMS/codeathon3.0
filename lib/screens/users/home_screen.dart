import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> farmers = [];

  @override
  void initState() {
    super.initState();
    fetchFarmers();
  }

  Future<void> fetchFarmers() async {
    try {
      // Simulated API response
      await Future.delayed(Duration(seconds: 2)); // Mock network delay
      setState(() {
        farmers = [
          {
            "name": "John's Organic Farm",
            "location": "California, USA",
            "profileImage": "https://via.placeholder.com/150",
            "products": [
              {
                "name": "Fresh Apples",
                "price": "\$3/kg",
                "image": "https://via.placeholder.com/100"
              },
              {
                "name": "Organic Tomatoes",
                "price": "\$2.5/kg",
                "image": "https://via.placeholder.com/100"
              }
            ]
          },
          {
            "name": "Green Valley Farm",
            "location": "Texas, USA",
            "profileImage": "https://via.placeholder.com/150",
            "products": [
              {
                "name": "Wheat",
                "price": "\$1.5/kg",
                "image": "https://via.placeholder.com/100"
              },
              {
                "name": "Rice",
                "price": "\$2/kg",
                "image": "https://via.placeholder.com/100"
              }
            ]
          }
        ];
      });
    } catch (e) {
      print("Error fetching farmers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Farmers' Market", style: GoogleFonts.poppins(fontSize: 20)),
        centerTitle: true,
      ),
      body: farmers.isEmpty
          ? Center(child: Lottie.asset("assets/loading.json", width: 150))
          : ListView.builder(
        itemCount: farmers.length,
        itemBuilder: (context, index) {
          final farmer = farmers[index];
          return FadeInUp(
            child: Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: farmer["profileImage"],
                        placeholder: (context, url) =>
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                  width: 50, height: 50, color: Colors.white),
                            ),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(farmer["name"], style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        farmer["location"], style: GoogleFonts.poppins()),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 120,
                    child: FlutterCarousel(
                      options: FlutterCarouselOptions(
                        height: 120,
                        autoPlay: true,
                        viewportFraction: 0.6,
                      ),
                      items: farmer["products"].map<Widget>((product) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: product["image"],
                                height: 50,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                              Text(product["name"], style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500)),
                              Text(product["price"], style: GoogleFonts.poppins(
                                  color: Colors.green)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}