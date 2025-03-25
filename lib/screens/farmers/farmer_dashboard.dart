// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:lottie/lottie.dart';
// import 'package:animate_do/animate_do.dart';
//
// class FarmerDashboard extends StatefulWidget {
//   @override
//   _FarmerDashboardState createState() => _FarmerDashboardState();
// }
//
// class _FarmerDashboardState extends State<FarmerDashboard> {
//   Map<String, dynamic>? farmerData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//   }
//
//   Future<void> fetchDashboardData() async {
//     try {
//       await Future.delayed(Duration(seconds: 2)); // Simulate API delay
//       setState(() {
//         farmerData = {
//           "name": "John Doe",
//           "email": "johndoe@example.com",
//           "phone": "+91 9876543210",
//           "farmName": "Green Valley Farm",
//           "location": "Village, State",
//           "profileImage": "https://via.placeholder.com/150",
//           "totalProducts": 5,
//           "latestProducts": [
//             {"name": "Tomatoes", "price": "₹50/kg"},
//             {"name": "Organic Wheat", "price": "₹80/kg"}
//           ],
//           "totalOrders": 12,
//           "orderStatus": {"Pending": 3, "Accepted": 5, "Shipped": 2, "Delivered": 2},
//           "pendingNegotiations": 2,
//           "recentMessages": [
//             {"sender": "Buyer123", "message": "Can I get a discount?"},
//             {"sender": "Buyer456", "message": "Need bulk order pricing."}
//           ],
//         };
//       });
//     } catch (e) {
//       print("Error fetching dashboard data: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text("Farmer Dashboard", style: GoogleFonts.poppins(color: Colors.white)),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: farmerData == null
//           ? Center(
//               child: Lottie.asset('assets/loading.json', width: 150),
//             )
//           : SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildProfileSection(),
//                   SizedBox(height: 20),
//                   _buildDashboardCards(),
//                   SizedBox(height: 20),
//                   _buildRecentSection("Latest Products", _buildLatestProducts()),
//                   SizedBox(height: 20),
//                   _buildRecentSection("Recent Messages", _buildRecentMessages()),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget _buildProfileSection() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: CachedNetworkImage(
//                 imageUrl: farmerData!["profileImage"] ?? "",
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: CircleAvatar(radius: 40),
//                 ),
//                 errorWidget: (context, url, error) =>
//                     Icon(Icons.error, size: 60),
//               ),
//             ),
//             SizedBox(width: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(farmerData!["name"], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text(farmerData!["farmName"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
//                 Text(farmerData!["location"], style: GoogleFonts.poppins(color: Colors.grey.shade600)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardCards() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(child: _buildDashboardCard("Total Products", farmerData!["totalProducts"].toString(), Icons.local_florist)),
//         Expanded(child: _buildDashboardCard("Total Orders", farmerData!["totalOrders"].toString(), Icons.shopping_basket)),
//         Expanded(child: _buildDashboardCard("Pending Negotiations", farmerData!["pendingNegotiations"].toString(), Icons.chat)),
//       ],
//     );
//   }
//
//
//   Widget _buildDashboardCard(String title, String value, IconData icon) {
//     return FadeInUp(
//       duration: Duration(milliseconds: 500),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Icon(icon, size: 30, color: Colors.green.shade700),
//               SizedBox(height: 8),
//               Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
//               Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade700)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecentSection(String title, Widget child) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10),
//         child,
//       ],
//     );
//   }
//
//   Widget _buildLatestProducts() {
//     return Column(
//       children: farmerData!["latestProducts"].map<Widget>((product) {
//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: ListTile(
//             leading: Icon(Icons.shopping_bag, color: Colors.green.shade700),
//             title: Text(product["name"], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//             subtitle: Text(product["price"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildRecentMessages() {
//     return Column(
//       children: farmerData!["recentMessages"].map<Widget>((message) {
//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: ListTile(
//             leading: Icon(Icons.message, color: Colors.green.shade700),
//             title: Text(message["sender"], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//             subtitle: Text(message["message"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:untitled1/screens/farmers/add_product.dart';
import 'package:untitled1/screens/farmers/negotiation.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FarmerDashboard(),
  ));
}

class FarmerDashboard extends StatefulWidget {
  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  Map<String, dynamic>? farmerData;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      setState(() {
        farmerData = {
          "name": "John Doe",
          "email": "johndoe@example.com",
          "phone": "+91 9876543210",
          "farmName": "Green Valley Farm",
          "location": "Village, State",
          "profileImage": "https://via.placeholder.com/150",
          "totalProducts": 5,
          "latestProducts": [
            {"name": "Tomatoes", "price": "₹50/kg"},
            {"name": "Organic Wheat", "price": "₹80/kg"}
          ],
          "totalOrders": 12,
          "orderStatus": {"Pending": 3, "Accepted": 5, "Shipped": 2, "Delivered": 2},
          "pendingNegotiations": 2,
          "recentMessages": [
            {"sender": "Buyer123", "message": "Can I get a discount?"},
            {"sender": "Buyer456", "message": "Need bulk order pricing."}
          ],
        };
      });
    } catch (e) {
      print("Error fetching dashboard data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Farmer Dashboard", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.green.shade700,

      ),
      body: farmerData == null
          ? Center(
        // child: Lottie.asset('assets/loading.json', width: 150),
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            SizedBox(height: 20),
            _buildDashboardCards(),
            SizedBox(height: 20),
            _buildNegotiationButton(), // Add Negotiation Button
            SizedBox(height: 20),
            _buildRecentSection("Latest Products", _buildLatestProducts()),
            SizedBox(height: 20),
            _buildRecentSection("Recent Messages", _buildRecentMessages()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: farmerData!["profileImage"] ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: CircleAvatar(radius: 40),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, size: 60),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(farmerData!["name"], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(farmerData!["farmName"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                Text(farmerData!["location"], style: GoogleFonts.poppins(color: Colors.grey.shade600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildRecentMessages() {
    return Column(
      children: farmerData!["recentMessages"].map<Widget>((message) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(Icons.message, color: Colors.green.shade700),
            title: Text(message["sender"], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            subtitle: Text(message["message"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
          ),
        );
      }).toList(),
    );
  }

    Widget _buildLatestProducts() {
    return Column(
      children: farmerData!["latestProducts"].map<Widget>((product) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.green.shade700),
            title: Text(product["name"], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            subtitle: Text(product["price"], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
          ),
        );
      }).toList(),
    );
  }

    Widget _buildRecentSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildDashboardCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: _buildDashboardCard("Total Products", farmerData!["totalProducts"].toString(), Icons.local_florist)),
        Expanded(child: _buildDashboardCard("Total Orders", farmerData!["totalOrders"].toString(), Icons.shopping_basket)),
        Expanded(child: _buildDashboardCard("Pending Negotiations", farmerData!["pendingNegotiations"].toString(), Icons.chat)),
      ],
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon) {
    return FadeInUp(
      duration: Duration(milliseconds: 500),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.green.shade700),
              SizedBox(height: 8),
              Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade700)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNegotiationButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NegotiationPage()));
        },
        icon: Icon(Icons.chat, color: Colors.white),
        label: Text("Pending Negotiations", style: GoogleFonts.poppins(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}