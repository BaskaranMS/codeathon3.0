import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  Map<String, dynamic>? trackingData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrackingDetails();
  }

  Future<void> fetchTrackingDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      setState(() {
        trackingData = {
          "orderId": "#12345",
          "status": "In Transit",
          "estimatedDelivery": DateTime.now().add(Duration(days: 3)),
          "trackingUpdates": [
            {"status": "Order Placed", "timestamp": DateTime.now().subtract(Duration(days: 2))},
            {"status": "Dispatched", "timestamp": DateTime.now().subtract(Duration(days: 1))},
            {"status": "In Transit", "timestamp": DateTime.now()}
          ]
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking", style: GoogleFonts.poppins()),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? buildShimmerEffect()
          : trackingData == null
              ? Center(child: Text("Failed to load data"))
              : buildTrackingDetails(),
    );
  }

  Widget buildShimmerEffect() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget buildTrackingDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID: ${trackingData!["orderId"]}",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Status: ${trackingData!["status"]}",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue)),
          SizedBox(height: 10),
          Text("Estimated Delivery: ${DateFormat.yMMMd().format(trackingData!["estimatedDelivery"])}",
              style: GoogleFonts.poppins(fontSize: 16)),
          SizedBox(height: 20),
          Divider(),
          Text("Tracking Updates", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: trackingData!["trackingUpdates"].length,
              itemBuilder: (context, index) {
                var update = trackingData!["trackingUpdates"][index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.local_shipping, color: Colors.green),
                    title: Text(update["status"], style: GoogleFonts.poppins(fontSize: 16)),
                    subtitle: Text(DateFormat.yMMMd().format(update["timestamp"])),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}