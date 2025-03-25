import 'package:flutter/material.dart';
import 'package:untitled1/screens/farmers/chat_screen.dart';
import 'package:untitled1/screens/farmers/orders_screen.dart';
import 'package:untitled1/screens/farmers/product_management.dart';
import 'package:untitled1/screens/farmers/profile_screen.dart';
import 'farmer_dashboard.dart';

class FarmerMainLayout extends StatefulWidget {
  const FarmerMainLayout({super.key});

  @override
  _FarmerMainLayoutState createState() => _FarmerMainLayoutState();
}

class _FarmerMainLayoutState extends State<FarmerMainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
     FarmerDashboard(),
     ProductManagementPage(),
     OrdersScreen(),
     ChatScreen(),
     FarmerPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
