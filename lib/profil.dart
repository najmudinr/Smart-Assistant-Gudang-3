import 'package:flutter/material.dart';
import 'package:smartassistant/editprofile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            // Avatar dan Informasi Nama
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'), // Ganti dengan path gambar Anda
            ),
            SizedBox(height: 10),
            Text(
              'Eri Pras',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'K.2000001',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // Container Informasi Karyawan
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Karyawan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  // Informasi Profil
                  ProfileInfoRow(label: 'Username', value: 'eripras11'),
                  ProfileInfoRow(label: 'Tempat Lahir', value: 'Gresik'),
                  ProfileInfoRow(label: 'Tanggal Lahir', value: '01 April 2020'),
                  ProfileInfoRow(label: 'Gender', value: 'Laki - laki'),
                  ProfileInfoRow(label: 'Alamat', value: 'Jalan jalan disana kemari'),
                  ProfileInfoRow(label: 'Nomor RT', value: '031'),
                  ProfileInfoRow(label: 'NIK', value: '3525131290123232'),
                  ProfileInfoRow(label: 'Nomor Handphone', value: '081220012345'),
                  ProfileInfoRow(label: 'Pendidikan Terakhir', value: 'SARJANA'),
                  ProfileInfoRow(label: 'Nomor BPJS', value: '000122899300'),
                  ProfileInfoRow(label: 'Nomor BPJS TK', value: '230009210'),
                  ProfileInfoRow(label: 'Nomor Pajak', value: '6222729301029380'),
                  ProfileInfoRow(label: 'Status Kawin', value: 'Belum Kawin'),
                  ProfileInfoRow(label: 'Agama', value: 'Islam'),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Tombol Edit Biodata
            ElevatedButton(
              onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: Text('Edit Biodata'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Widget untuk baris informasi profil
class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
