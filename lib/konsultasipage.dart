import 'package:flutter/material.dart';

class ConsultationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil lebar dan tinggi layar menggunakan MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, // Padding horizontal 4% dari lebar layar
          vertical: screenHeight * 0.02,  // Padding vertical 2% dari tinggi layar
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Jarak 2% dari tinggi layar
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Jumlah card yang ditampilkan
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02), // Padding bawah 2% dari tinggi layar
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04), // Padding dalam 4% dari lebar layar
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Topik : “Diskusi mengenai jam lembur”',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045, // Ukuran font proporsional dengan lebar layar
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01), // Jarak 1% dari tinggi layar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text('Dimulai pada : 05 Agustus 2024'),
                                ),
                                Flexible(
                                  child: Text(
                                    'Prioritas: Tinggi',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04, // Ukuran font proporsional
                                    ),
                                    textAlign: TextAlign.end, // Align teks ke kanan
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005), // Jarak 0.5% dari tinggi layar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Status: Aktif',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04, // Ukuran font proporsional
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Pesan : 3',
                                    textAlign: TextAlign.end, // Align teks ke kanan
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01), // Jarak 1% dari tinggi layar
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Aksi saat tombol "Lihat Detail" ditekan
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange, // Background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Lihat Detail'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk tombol tambah
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
