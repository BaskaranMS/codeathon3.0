import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> products = [];
  
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      setState(() {
        products = [
          {
            'name': 'Fresh Organic Tomatoes',
            'description': 'Locally grown, pesticide-free.',
            'price': 50,
            'quantity': 10,
            'category': 'Vegetables',
            'images': [
              'https://example.com/tomato.jpg'
            ],
          },
          {
            'name': 'Farm Fresh Apples',
            'description': 'Crisp and juicy apples.',
            'price': 80,
            'quantity': 15,
            'category': 'Fruits',
            'images': [
              'https://example.com/apple.jpg'
            ],
          },
        ];
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
      ),
      body: products.isEmpty
          ? Center(child: Lottie.asset('assets/loading.json', width: 150))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return FadeInUp(
                  duration: Duration(milliseconds: 500),
                  child: GestureDetector(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDe))
                    },
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: product['images'][0] ?? '',
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white,
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.image),
                        ),
                        title: Text(
                          product['name'] ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${product['category']} - ₹${product['price']}',
                          style: GoogleFonts.poppins(),
                        ),
                        trailing: Text(
                          '${product['quantity']} left',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
