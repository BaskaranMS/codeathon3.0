import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? farmerData;

  @override
  void initState() {
    super.initState();
    fetchFarmerDetails();
  }

  Future<void> fetchFarmerDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      setState(() {
        farmerData = {
          "name": "John Doe",
          "email": "johndoe@example.com",
          "phone": "+91 9876543210",
          "farmName": "Green Valley Farms",
          "location": "Pune, India",
          "profileImage": "https://via.placeholder.com/150",
          "bio": "Experienced organic farmer specializing in sustainable farming techniques.",
          "experience": "10 years in organic farming",
          "certifications": ["Organic Farming Certified", "Soil Health Specialist"],
          "farmImages": [
            "https://via.placeholder.com/300",
            "https://via.placeholder.com/300"
          ]
        };
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer Profile", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
      ),
      body: farmerData == null
          ? Center(child: Lottie.asset('assets/loading.json', width: 100))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: farmerData!["profileImage"],
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child: CircleAvatar(radius: 50, backgroundColor: Colors.grey),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      farmerData!["name"],
                      style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      farmerData!["farmName"],
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInfoTile("Email", farmerData!["email"]),
                  _buildInfoTile("Phone", farmerData!["phone"]),
                  _buildInfoTile("Location", farmerData!["location"]),
                  _buildInfoTile("Bio", farmerData!["bio"]),
                  _buildInfoTile("Experience", farmerData!["experience"]),
                  _buildCertifications(),
                  _buildFarmImages(),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: GoogleFonts.poppins()),
        leading: Icon(Icons.info_outline, color: Colors.green),
      ),
    );
  }

  Widget _buildCertifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Certifications", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        ...farmerData!["certifications"].map<Widget>((cert) => FadeIn(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(cert, style: GoogleFonts.poppins()),
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildFarmImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Farm Images", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: farmerData!["farmImages"].length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: OpenContainer(
                  closedElevation: 5,
                  closedBuilder: (context, action) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: farmerData!["farmImages"][index],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.white,
                        child: Container(width: 150, height: 150, color: Colors.grey),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  openBuilder: (context, action) => Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: CachedNetworkImage(imageUrl: farmerData!["farmImages"][index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}