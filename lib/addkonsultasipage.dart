import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartassistant/konsultasipage.dart';

class AddConsultationPage extends StatefulWidget {
  @override
  _AddConsultationPageState createState() => _AddConsultationPageState();
}

class _AddConsultationPageState extends State<AddConsultationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _priority = 'Rendah';
  String? _selectedAtasan;
  String? _uploadedFileUrl;

  // Method untuk mengambil data atasan dari Firestore
  Future<List<QueryDocumentSnapshot>> _fetchAtasan() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('atasan').get();
    return snapshot.docs;
  }

  Future<void> _pickFile() async {
    // Menggunakan file_picker untuk memilih file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Mendapatkan file yang dipilih
      PlatformFile file = result.files.first;

      try {
        // Mengunggah file ke Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('consultations/${file.name}');
        UploadTask uploadTask = storageRef.putData(file.bytes!);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Mendapatkan URL unduhan file
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          _uploadedFileUrl = downloadUrl;
        });

        // Menampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File berhasil diunggah')));
      } catch (e) {
        // Menampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengunggah file: $e')));
      }
    }
  }

  Future<void> _submitConsultation() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        // Menyimpan data konsultasi ke Firestore
        await FirebaseFirestore.instance.collection('consultations').add({
          'userId': user?.uid,
          'topic': _topicController.text,
          'description': _descriptionController.text,
          'priority': _priority,
          'atasan': _selectedAtasan,
          'fileUrl': _uploadedFileUrl, // Menyimpan URL file ke Firestore
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'Aktif',
        });

        // Mengirim notifikasi ke atasan
        await FirebaseFirestore.instance.collection('notifications').add({
          'receiverId': _selectedAtasan,
          'message': 'Anda menerima konsultasi baru',
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Menampilkan alert jika berhasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Konsultasi berhasil diajukan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup alert
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ConsultationPage(),
                    ),
                  ); // Navigasi ke ConsultationPage
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Gagal mengajukan konsultasi: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup alert
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Konsultasi Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _topicController,
                  decoration: InputDecoration(labelText: 'Topik Konsultasi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tulis topik konsultasi di sini';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tulis deskripsi di sini';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                Text('Prioritas :'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Rendah',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value!;
                        });
                      },
                    ),
                    Text('Rendah'),
                    Radio<String>(
                      value: 'Tinggi',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value!;
                        });
                      },
                    ),
                    Text('Tinggi'),
                  ],
                ),
                FutureBuilder<List<QueryDocumentSnapshot>>(
                  future: _fetchAtasan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Tidak ada data atasan');
                    }
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Tujuan'),
                      items: snapshot.data!
                          .map((atasan) => DropdownMenuItem(
                                value: atasan.id,
                                child: Text(atasan['nama']),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAtasan = value;
                        });
                      },
                      value: _selectedAtasan,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih atasan';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 16),
                Text('Lampiran:'),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                if (_uploadedFileUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('File berhasil diunggah: $_uploadedFileUrl'),
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: _submitConsultation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Ajukan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
