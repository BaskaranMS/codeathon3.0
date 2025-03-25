import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/auth/login.dart';
import 'package:untitled1/screens/farmers/farmer_dashboard.dart';
import 'package:untitled1/screens/farmers/farmer_mainlayout.dart';
import 'package:untitled1/screens/users/userPageLayout.dart';
import 'package:untitled1/screens/users/user_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FarmersMarketplaceApp());
}

class FarmersMarketplaceApp extends StatelessWidget {
  const FarmersMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userType = prefs.getString('userType'); // "farmer" or "user"
      String? token = prefs.getString('token');

      await Future.delayed(const Duration(seconds: 2)); // Simulate loading

      if (token != null && userType != null) {
        if (userType == "farmer") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserPageLayout()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserPageLayout()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserPageLayout()));
      }
    } catch (e) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FarmerMainLayout()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/loading.json', width: 200, height: 200),
      ),
    );
  }
}
