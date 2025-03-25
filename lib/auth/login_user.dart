import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      return {
        "name": "Test User",
        "email": "test@example.com",
        "phone": "9876543210",
        "profileImage": "https://via.placeholder.com/150"
      };
    } catch (e) {
      return {"error": "Failed to fetch user data"};
    }
  }

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Map<String, dynamic> userData = await fetchUserData();
      setState(() => _isLoading = false);

      if (!userData.containsKey("error")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userEmail", userData["email"]);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed! Try Again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) => value!.isEmpty ? "Enter a valid email" : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) => value!.length < 6 ? "Password must be 6+ chars" : null,
                ),
                SizedBox(height: 20),
                _isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: loginUser,
                        child: Text("Login"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
