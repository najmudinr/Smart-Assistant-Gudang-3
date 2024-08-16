import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Tetap gunakan Scaffold jika ada AppBar dan Drawer
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Dashboard', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 16),
          CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Jabatan/Role',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Tambahkan ListTile lainnya untuk menu drawer
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                AgendaCard(screenWidth: screenWidth),
                PetugasCard(screenWidth: screenWidth),
                ChartCard(screenWidth: screenWidth)
              ],
            ),
          );
        },
      ),
    );
  }
}

// AgendaCard dan PetugasCard tidak berubah

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


class ChartCard extends StatelessWidget {
  final double screenWidth;

  ChartCard({required this.screenWidth});

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