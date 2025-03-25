import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';

class FarmerPage extends StatefulWidget {
  @override
  _FarmerPageState createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  Map<String, dynamic>? farmerData;

  @override
  void initState() {
    super.initState();
    fetchFarmerDetails();
  }

  Future<void> fetchFarmerDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      setState(() {
        farmerData = {
          "name": "John Doe",
          "email": "johndoe@example.com",
          "phone": "+91 9876543210",
          "farmName": "Green Valley Farm",
          "location": "Village, State",
          "profileImage":
              "https://via.placeholder.com/150",
          "products": ["Tomatoes", "Wheat", "Milk"],
          "orders": ["Order #123", "Order #456"],
          "createdAt": "2025-03-25",
        };
      });
    } catch (e) {
      print("Error fetching farmer details: $e");
    }
  }

  void editProfile() {
    TextEditingController nameController =
        TextEditingController(text: farmerData?["name"]);
    TextEditingController phoneController =
        TextEditingController(text: farmerData?["phone"]);
    TextEditingController farmController =
        TextEditingController(text: farmerData?["farmName"]);
    TextEditingController locationController =
        TextEditingController(text: farmerData?["location"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile", style: TextStyle(color: Colors.white),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("Name", nameController),
                _buildTextField("Phone", phoneController),
                _buildTextField("Farm Name", farmController),
                _buildTextField("Location", locationController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  farmerData!["name"] = nameController.text;
                  farmerData!["phone"] = phoneController.text;
                  farmerData!["farmName"] = farmController.text;
                  farmerData!["location"] = locationController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Farmer Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: editProfile,
          ),
        ],
      ),
      body: farmerData == null
          ? Center(
        // child: Lottie.asset('assets/loading.json', width: 150),
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: farmerData!["profileImage"] ?? "",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: CircleAvatar(radius: 60),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 80),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _infoTile("👤 Name", farmerData!["name"]),
              _infoTile("📧 Email", farmerData!["email"]),
              _infoTile("📞 Phone", farmerData!["phone"]),
              _infoTile("🏡 Farm", farmerData!["farmName"]),
              _infoTile("📍 Location", farmerData!["location"]),
              _infoTile("🛒 Products", farmerData!["products"].join(", ")),
              _infoTile("📦 Orders", farmerData!["orders"].join(", ")),
              _infoTile("📅 Joined", farmerData!["createdAt"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.info, color: Colors.green.shade700),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.poppins(),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 2, // Avoids overflow
        ),
      ),
    );
  }
}
