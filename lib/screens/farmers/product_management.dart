import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';

class ProductManagementPage extends StatefulWidget {
  @override
  _ProductManagementPageState createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      setState(() {
        products = [
          {
            'name': 'Organic Apples',
            'description': 'Fresh organic apples from our farm.',
            'price': 150,
            'quantity': 20,
            'category': 'Fruits',
            'images': 'https://via.placeholder.com/150'
          },
          {
            'name': 'Pure Honey',
            'description': 'Natural honey collected from bees.',
            'price': 200,
            'quantity': 10,
            'category': 'Dairy',
            'images': 'https://via.placeholder.com/150'
          }
        ];
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management', style: GoogleFonts.poppins()),
      ),
      body: products.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return FadeIn(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: product['images'],
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
                      title: Text(product['name'], style: GoogleFonts.poppins()),
                      subtitle: Text('Price: ₹${product['price']} | Stock: ${product['quantity']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle product addition
        },
        child: Icon(Icons.add),
      ),
    );
  }
}