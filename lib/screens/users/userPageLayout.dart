import 'package:flutter/material.dart';
import 'package:untitled1/screens/users/user_home_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'order_summary.dart';
import 'chat_screen.dart';

class UserPageLayout extends StatefulWidget {
  @override
  _UserPageLayoutState createState() => _UserPageLayoutState();
}

class _UserPageLayoutState extends State<UserPageLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserHomeScreen(),
    OrderSummaryScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
