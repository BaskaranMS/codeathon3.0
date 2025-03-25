import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      setState(() {
        orders = [
          {
            "buyer": "John Doe",
            "totalAmount": 150.0,
            "status": "Pending",
            "paymentStatus": "Completed",
            "createdAt": DateTime.now().subtract(Duration(days: 1)),
            "products": [
              {
                "name": "Tomatoes",
                "quantity": 10,
                "price": 15.0,
                "image": "https://source.unsplash.com/200x200/?tomatoes"
              },
              {
                "name": "Potatoes",
                "quantity": 5,
                "price": 20.0,
                "image": "https://source.unsplash.com/200x200/?potatoes"
              },
            ]
          }
        ];
      });
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text("Orders", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: orders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return FadeInUp(
                  duration: Duration(milliseconds: 500),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Buyer: ${order['buyer']}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 5),
                          Text("Total Amount: ₹${order['totalAmount']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("Status: ${order['status']}", style: TextStyle(fontSize: 14, color: Colors.blue)),
                          Text("Payment: ${order['paymentStatus']}", style: TextStyle(fontSize: 14, color: Colors.green)),
                          Text("Date: ${DateFormat.yMMMd().format(order['createdAt'])}", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: order['products'].length,
                              itemBuilder: (context, i) {
                                final product = order['products'][i];
                                return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: product['image'],
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(height: 60, width: 60, color: Colors.white),
                                          ),
                                          errorWidget: (context, url, error) => Icon(Icons.broken_image, size: 60, color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(product['name'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                      Text("Qty: ${product['quantity']}", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
