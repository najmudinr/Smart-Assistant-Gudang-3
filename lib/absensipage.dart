import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as fdp;
import 'package:intl/intl.dart';


class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  DateTime selectedDate = DateTime.now();

  void _selectDate() {
    fdp.DatePicker.showDatePicker(
      context,
      theme: fdp.DatePickerTheme(
        containerHeight: 210.0,
      ),
      showTitleActions: true,
      minTime: DateTime(2022, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onConfirm: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: fdp.LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pilih Tanggal'),
                InkWell(
                  onTap: _selectDate,
                  child: Row(
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                      Icon(Icons.calendar_today)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Statistics Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatisticCard('Pegawai', '110 Orang', Icons.person),
                _buildStatisticCard('Cuti', '22', Icons.work_off, '+50% dari bulan lalu'),
                _buildStatisticCard('Sakit', '2', Icons.healing, '+10% dari bulan lalu'),
                _buildStatisticCard('Izin', '2', Icons.book, '+10% dari bulan lalu'),
              ],
            ),
            SizedBox(height: 16),
            // Line Chart
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(sideTitles: _buildBottomTitles()),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [FlSpot(0, 60), FlSpot(1, 50), FlSpot(2, 55), FlSpot(3, 45), FlSpot(4, 65)],
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Pie Chart
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 18, color: Colors.red, title: '18'),
                    PieChartSectionData(value: 14, color: Colors.green, title: '14'),
                    PieChartSectionData(value: 14, color: Colors.orange, title: '14'),
                    PieChartSectionData(value: 14, color: Colors.blue, title: '14'),
                    PieChartSectionData(value: 12, color: Colors.yellow, title: '12'),
                    PieChartSectionData(value: 11, color: Colors.purple, title: '11'),
                    PieChartSectionData(value: 10, color: Colors.brown, title: '10'),
                    PieChartSectionData(value: 6, color: Colors.teal, title: '6'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value, IconData icon, [String? subtitle]) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 40),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title),
            if (subtitle != null)
              Text(subtitle, style: TextStyle(color: Colors.green, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  SideTitles _buildBottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        switch (value.toInt()) {
          case 0:
            return Text('22/04');
          case 1:
            return Text('23/04');
          case 2:
            return Text('24/04');
          case 3:
            return Text('25/04');
        }
        return Text('');
      },
    );
  }
}
