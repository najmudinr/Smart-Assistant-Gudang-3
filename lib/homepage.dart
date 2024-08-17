import 'package:flutter/material.dart';
import 'package:smartassistant/dashboardpage.dart';
import 'package:smartassistant/konsultasipage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    PlaceholderWidget(color: Colors.green), // Placeholder untuk Absensi
    PlaceholderWidget(color: Colors.blue), // Placeholder untuk News & Event
    PlaceholderWidget(color: Colors.red), // Placeholder untuk Produk
    PlaceholderWidget(color: Colors.orange) // Placeholder untuk Report
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScaffoldWithNavbar(page: page)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Tambahkan fungsi untuk notifikasi di sini
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Tambahkan fungsi untuk avatar di sini (misalnya menuju halaman profil)
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Konsultasi'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage(ConsultationPage());
              },
            ),
            // Tambahkan item drawer lainnya di sini
          ],
        ),
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
        unselectedItemColor:
            Colors.white60, // Menetapkan warna ikon yang tidak dipilih
        backgroundColor: Color.fromRGBO(
            75, 185, 236, 100), // Pastikan backgroundColor diatur di sini
        type: BottomNavigationBarType
            .fixed, // Agar warna background tidak berubah saat ada lebih dari 3 item
        onTap: _onItemTapped,
      ),
    );
  }
}

class ScaffoldWithNavbar extends StatelessWidget {
  final Widget page;

  ScaffoldWithNavbar({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: page,
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
        ], // Set sesuai tab yang relevan
        selectedItemColor: Colors.white,
        backgroundColor: Color.fromRGBO(75, 185, 236, 100),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          Navigator.pop(context); // Tutup halaman saat item dipilih
        },
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
