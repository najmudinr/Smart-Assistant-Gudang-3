import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartassistant/absensipage.dart';
import 'package:smartassistant/dashboardpage.dart';
import 'package:smartassistant/loginpage.dart';
import 'package:smartassistant/newsevenpage.dart';
import 'package:smartassistant/productpage.dart';
import 'package:smartassistant/reportpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _buildPage(DashboardPage(), 'Dashboard'),
    _buildPage(AbsensiPage(), 'Absensi'),
    _buildPage(NewsEventPage(), 'News & Event'),
    _buildPage(ProductPage(), 'Produk'),
    _buildPage(ReportPage(), 'Report'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static Widget _buildPage(Widget page, String title) {
    return Scaffold(
      body: page,
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.person, color: Colors.black),
            onSelected: (String result) {
              if (result == 'Logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'News & Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: Color.fromRGBO(75, 185, 236, 100),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
