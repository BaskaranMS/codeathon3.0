import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerLoginScreen extends StatefulWidget {
  @override
  _FarmerLoginScreenState createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _fetchFarmerData() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      return {
        "name": "Test Farmer",
        "email": "farmer@example.com",
        "phone": "1234567890",
        "farmName": "Green Fields",
        "location": "Village, India"
      };
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }

  Future<void> _loginFarmer() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulating API call
      await Future.delayed(Duration(seconds: 2));
      final response = {
        "success": true,
        "message": "Login successful",
        "data": {
          "name": "Test Farmer",
          "email": _emailController.text,
          "phone": "1234567890",
          "farmName": "Green Fields",
          "location": "Village, India"
        }
      };

      if (response["success"]) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("farmerName", response["data"]["name"]);
        prefs.setString("farmerEmail", response["data"]["email"]);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"])));
      }
    } catch (e) {
      print("Login error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Text(
                  "Farmer Login",
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 15),
              FadeInRight(
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : FadeInUp(
                      child: ElevatedButton(
                        onPressed: _loginFarmer,
                        child: Text("Login"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}