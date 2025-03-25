import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  Map<String, dynamic>? orderDetails;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        orderDetails = {
          "buyer": "John Doe",
          "farmer": "Farmer Joe",
          "products": [
            {
              "name": "Organic Tomatoes",
              "quantity": 2,
              "price": 50.0,
              "image": "https://via.placeholder.com/150"
            },
            {
              "name": "Fresh Carrots",
              "quantity": 1,
              "price": 30.0,
              "image": "https://via.placeholder.com/150"
            }
          ],
          "totalAmount": 130.0,
          "status": "Pending",
          "paymentStatus": "Pending",
          "createdAt": DateTime.now().toString()
        };
      });
    } catch (error) {
      print("Error fetching order details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green.shade700,
      ),
      body: orderDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buyer: ${orderDetails!["buyer"]}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Farmer: ${orderDetails!["farmer"]}",
                      style: TextStyle(fontSize: 16)),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderDetails!["products"].length,
                      itemBuilder: (context, index) {
                        var product = orderDetails!["products"][index];
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: product["image"],
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
                          title: Text(product["name"],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("Quantity: ${product["quantity"]} x Rs. ${product["price"]}"),
                          trailing: Text("Rs. ${product["quantity"] * product["price"]}"),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Text("Total Amount: Rs. ${orderDetails!["totalAmount"]}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Status: ${orderDetails!["status"]}",
                      style: TextStyle(fontSize: 16, color: Colors.orange)),
                  Text("Payment Status: ${orderDetails!["paymentStatus"]}",
                      style: TextStyle(fontSize: 16, color: Colors.red)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Proceed to Payment"),
                  )
                ],
              ),
            ),
    );
  }
}
