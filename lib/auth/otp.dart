import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _fetchOtpDetails();
  }
  
  Future<void> _fetchOtpDetails() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock API delay
      return; // Sample data handling
    } catch (e) {
      debugPrint("Error fetching OTP details: $e");
    }
  }
  
  void _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (_otpController.text == "123456") { // Mock OTP verification
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP. Try again!"))
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              child: Lottie.asset(
                "assets/otp_animation.json",
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Enter OTP sent to ${widget.phoneNumber}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Pinput(
              controller: _otpController,
              length: 6,
              keyboardType: TextInputType.number,
              onCompleted: (value) => _verifyOtp(),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text("Verify OTP"),
                  ),
          ],
        ),
      ),
    );
  }
}