import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return; // Simulated API call returning sample data
    } catch (e) {
      print("Error fetching data: \$e");
    }
  }

  void _handleSignup() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _farmNameController.text.isEmpty ||
        _locationController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulating API response

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("farmer_name", _nameController.text);

    setState(() {
      _isLoading = false;
    });

    Fluttertoast.showToast(msg: "Signup Successful!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Farmer Signup", style: GoogleFonts.poppins()),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Register as a Farmer", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Full Name")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email"), keyboardType: TextInputType.emailAddress),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: "Phone Number"), keyboardType: TextInputType.phone),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            TextField(controller: _farmNameController, decoration: InputDecoration(labelText: "Farm Name")),
            TextField(controller: _locationController, decoration: InputDecoration(labelText: "Location")),
            SizedBox(height: 20),
            _isLoading
                ? Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.white,
                      child: Container(height: 50, width: double.infinity, color: Colors.grey),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _handleSignup,
                    child: Text("Sign Up"),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
          ],
        ),
      ),
    );
  }
}
