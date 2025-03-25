import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class NegotiationScreen extends StatefulWidget {
  @override
  _NegotiationScreenState createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  Map<String, dynamic>? negotiationData;
  TextEditingController offerController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNegotiationDetails();
  }

  Future<void> fetchNegotiationDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      setState(() {
        negotiationData = {
          "buyer": "John Doe",
          "farmer": "Farmer Smith",
          "product": {
            "name": "Organic Tomatoes",
            "price": 200,
            "image": "https://example.com/tomatoes.jpg",
          },
          "initialPrice": 200,
          "offeredPrice": 180,
          "farmerResponse": 190,
          "status": "Pending",
          "messages": [
            {"sender": "Farmer Smith", "text": "I can offer at 190."},
            {"sender": "John Doe", "text": "Can you do 180?"},
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
        title: Text("Negotiation", style: GoogleFonts.poppins(fontSize: 20)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset("assets/loading.json", width: 150, height: 150),
            )
          : negotiationData == null
              ? Center(child: Text("Failed to load data"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: negotiationData!["product"]["image"],
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          title: Text(negotiationData!["product"]["name"],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "Initial Price: \u{20B9}${negotiationData!["initialPrice"]}"),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: negotiationData!["messages"].length,
                          itemBuilder: (context, index) {
                            var msg = negotiationData!["messages"][index];
                            return FadeIn(
                              child: ListTile(
                                title: Text(msg["sender"],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(msg["text"]),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: offerController,
                              decoration: InputDecoration(
                                hintText: "Enter your offer",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (offerController.text.isNotEmpty) {
                                setState(() {
                                  negotiationData!["messages"].add({
                                    "sender": "John Doe",
                                    "text": "Offering \u{20B9}${offerController.text}" 
                                  });
                                  offerController.clear();
                                });
                              }
                            },
                            child: Text("Offer"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
    );
  }
}
