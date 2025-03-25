import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails();
  }

  Future<void> fetchPaymentDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        paymentDetails = {
          "buyerName": "John Doe",
          "farmerName": "Farmer Joe",
          "amount": 1200,
          "paymentMethod": "UPI",
          "transactionId": "TXN123456789",
          "status": "Completed",
          "date": DateTime.now(),
        };
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details", style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: Lottie.asset('assets/loading.json', width: 100))
          : paymentDetails == null
              ? Center(child: Text("Failed to load payment details."))
              : FadeInUp(
                  duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildDetailRow("Buyer:", paymentDetails!["buyerName"]),
                            _buildDetailRow("Farmer:", paymentDetails!["farmerName"]),
                            _buildDetailRow("Amount:", "₹${paymentDetails!["amount"]}"),
                            _buildDetailRow("Payment Method:", paymentDetails!["paymentMethod"]),
                            _buildDetailRow("Transaction ID:", paymentDetails!["transactionId"]),
                            _buildDetailRow("Status:", paymentDetails!["status"]),
                            _buildDetailRow("Date:", DateFormat.yMMMd().format(paymentDetails!["date"])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          Text(value, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }
}
