import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NegotiationPage extends StatefulWidget {
  @override
  _NegotiationPageState createState() => _NegotiationPageState();
}

class _NegotiationPageState extends State<NegotiationPage> {
  Map<String, dynamic>? negotiationData;

  @override
  void initState() {
    super.initState();
    fetchNegotiationDetails();
  }

  Future<void> fetchNegotiationDetails() async {
    try {
      // Simulate fetching negotiation details (Replace this with actual API call)
      setState(() {
        negotiationData = {
          "product": "Organic Tomatoes",
          "initialPrice": 50,
          "offeredPrice": 40,
          "farmerResponse": 45,
          "status": "Pending",
          "messages": [
            {"sender": "Buyer", "text": "Can you lower the price?"},
            {"sender": "Farmer", "text": "How about 45?"},
          ]
        };
      });
    } catch (error) {
      print("Error fetching negotiation details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text("Negotiation Details", style: GoogleFonts.poppins(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: negotiationData == null
          ? Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(height: 20, width: 100, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: Text(
                      "Product: ${negotiationData!["product"]}",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInLeft(
                    child: Text(
                      "Initial Price: ₹${negotiationData!["initialPrice"]}",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  FadeInLeft(
                    child: Text(
                      "Offered Price: ₹${negotiationData!["offeredPrice"]}",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  FadeInLeft(
                    child: Text(
                      "Farmer Response: ₹${negotiationData!["farmerResponse"]}",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  FadeInLeft(
                    child: Text(
                      "Status: ${negotiationData!["status"]}",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: negotiationData!["messages"].length,
                      itemBuilder: (context, index) {
                        var message = negotiationData!["messages"][index];
                        return ListTile(
                          title: Text(
                            "${message["sender"]}: ${message["text"]}",
                            style: GoogleFonts.poppins(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Accept", style: GoogleFonts.poppins()),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Counteroffer", style: GoogleFonts.poppins()),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Reject", style: GoogleFonts.poppins()),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
