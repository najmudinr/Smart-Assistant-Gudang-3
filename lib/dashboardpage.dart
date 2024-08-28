import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smartassistant/comdev.dart';
import 'package:smartassistant/disposisi.dart';
import 'package:smartassistant/konsultasipage.dart';
import 'package:smartassistant/laporan.dart';
import 'package:smartassistant/pengajuan.dart';
import 'package:smartassistant/penugasan.dart';
import 'package:smartassistant/projectmanagement.dart';
import 'package:smartassistant/teamwork.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _fetchUserNameFromFirestore();  // Tambahkan ini untuk memanggil Firestore
  }

  Future<void> _loadUserName() async {
    // Ambil nama dari SharedPreferences jika tersedia
    final prefs = await SharedPreferences.getInstance();
    String? cachedName = prefs.getString('userName');

    setState(() {
      userName = cachedName;
    });
  }

  Future<void> _fetchUserNameFromFirestore() async {
    try {
      print("Fetching user name...");
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'];
          });

          // Simpan nama di SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userName', userName!);
        }
      }
    } catch (e, stackTrace) {
      print("Failed to fetch user name: $e");
      print(stackTrace);  // Print the stack trace to help with debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // Tampilkan teks "Selamat datang, $name"
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Text(
                    'Selamat datang, ${userName ?? 'Pengguna'}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Widget Dashboard Ikon Navigasi
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildDashboardItem(context, 'Penugasan', 'assets/penugasan.png', PenugasanPage()),
                      _buildDashboardItem(context, 'Comdev', 'assets/comdev.png', ComdevPage()),
                      _buildDashboardItem(context, 'Disposisi', 'assets/disposisi.png', DisposisiPage()),
                      _buildDashboardItem(context, 'Pengajuan', 'assets/pengajuan.png', PengajuanPage()),
                      _buildDashboardItem(context, 'Laporan', 'assets/laporan.png', LaporanPage()),
                      _buildDashboardItem(context, 'Teamwork Management', 'assets/teamwork.png', TeamworkManagementPage()),
                      _buildDashboardItem(context, 'Project Management', 'assets/project.png', ProjectManagementPage()),
                      _buildDashboardItem(context, 'Konsultasi', 'assets/konsultasi.png', ConsultationPage()),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Widgets yang sudah ada
                AgendaCard(screenWidth: screenWidth),
                PetugasCard(screenWidth: screenWidth),
                GudangInternalCard(screenWidth: screenWidth),
                GudangExternalCard(screenWidth: screenWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget untuk membangun item dashboard
  Widget _buildDashboardItem(BuildContext context, String title, String imagePath, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 30, width: 30),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
class AgendaCard extends StatelessWidget {
  final double screenWidth;

  AgendaCard({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(screenWidth * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agenda Bagian III Hari Ini',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text('Rabu, 20 Maret 2024'),
            SizedBox(height: screenWidth * 0.02),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: screenWidth * 0.05,
                columns: [
                  DataColumn(label: Text('Waktu')),
                  DataColumn(label: Text('Agenda')),
                  DataColumn(label: Text('Personel')),
                  DataColumn(label: Text('Tempat')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('08.00 - 09.00')),
                    DataCell(Text('Daily Meeting Pergudangan')),
                    DataCell(Text('Aminudin')),
                    DataCell(Text('Zoom Meetings')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('09.00 - 10.00')),
                    DataCell(Text('Rapat Bagian Minggu ke - III')),
                    DataCell(Text('All Staff Bagian Gudang III')),
                    DataCell(Text('Ruang Rapat Gudang III')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetugasCard extends StatelessWidget {
  final double screenWidth;

  PetugasCard({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(screenWidth * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Petugas Hari Ini',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text('20 Maret 2024 (Shift 1)'),
            SizedBox(height: screenWidth * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Foreman'),
                    Text('Lendy Tri', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loket'),
                    Text('Faisol Yunaedi', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Checker'),
                    Text(
                      'M. Hidayat Fanani\nM. Ustanul Arifin\nDavid Ardiansyah\nSimon M. K. W',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class GudangInternalCard extends StatelessWidget {
  final double screenWidth;

  GudangInternalCard({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(screenWidth * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Utilisasi Kapasitas Gudang Internal Area 3',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            SizedBox(
              height: screenWidth * 0.8,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 80000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          switch (value.toInt()) {
                            case 0:
                              return Text('GBB A', style: style);
                            case 1:
                              return Text('GBB B', style: style);
                            case 2:
                              return Text('GBB C', style: style);
                            case 3:
                              return Text('GMG I', style: style);
                            case 4:
                              return Text('GMG II', style: style);
                            default:
                              return Text('', style: style);
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text('${value.toInt()}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ));
                        },
                        interval: 10000,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  barGroups: _createBarGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 50000, color: Colors.blue),
        BarChartRodData(toY: 46900, color: Colors.red),
        BarChartRodData(toY: 3100, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 50000, color: Colors.blue),
        BarChartRodData(toY: 39575, color: Colors.red),
        BarChartRodData(toY: 10424, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 41886, color: Colors.blue),
        BarChartRodData(toY: 18831, color: Colors.red),
        BarChartRodData(toY: 23054, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: 53090, color: Colors.blue),
        BarChartRodData(toY: 29710, color: Colors.red),
        BarChartRodData(toY: 23379, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(toY: 78460, color: Colors.blue),
        BarChartRodData(toY: 56593, color: Colors.red),
        BarChartRodData(toY: 21866, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
    ];
  }
}

class GudangExternalCard extends StatelessWidget {
  final double screenWidth;

  GudangExternalCard({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(screenWidth * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Utilisasi Kapasitas Gudang External Area 3',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            SizedBox(
              height: screenWidth * 0.8,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 80000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          switch (value.toInt()) {
                            case 0:
                              return Text('KIG Beton', style: style);
                            case 1:
                              return Text('KIG FB', style: style);
                            case 2:
                              return Text('KIG Q', style: style);
                            default:
                              return Text('', style: style);
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text('${value.toInt()}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ));
                        },
                        interval: 10000,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  barGroups: _createBarGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 21000, color: Colors.blue),
        BarChartRodData(toY: 10000, color: Colors.red),
        BarChartRodData(toY: 11000, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 10000, color: Colors.blue),
        BarChartRodData(toY: 7800, color: Colors.red),
        BarChartRodData(toY: 2200, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 70000, color: Colors.blue),
        BarChartRodData(toY: 40000, color: Colors.red),
        BarChartRodData(toY: 30000, color: Colors.yellow),
      ], showingTooltipIndicators: [0, 1, 2]),
    ];
  }
}