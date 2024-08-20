/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartassistant/konsultasipage.dart';

Future<void> submitConsultation({
  required String topic,
  required String description,
  required String priority,
  required String receiverId,
  String? attachmentUrl,
}) async {
  try {
    await FirebaseFirestore.instance.collection('consultations').add({
      'topic': topic,
      'description': description,
      'priority': priority,
      'attachmentUrl': attachmentUrl ?? '',
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'receiverId': receiverId,
      'status': 'pending',
      'createdAt': Timestamp.now(),
    });
    // Alert dialog sukses
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Berhasil"),
          content: Text("Konsultasi berhasil diajukan."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultationPage()),
                ); // Pindah ke halaman ConsultationPage
              },
            ),
          ],
        );
      },
    );
  } catch (e) {
    // Tangani error
    print("Error: $e");
  }
}
 */