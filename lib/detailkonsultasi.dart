import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetailConsultationPage extends StatelessWidget {
  final String consultationId;

  DetailConsultationPage({required this.consultationId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Konsultasi"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('consultations')
              .doc(consultationId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var consultation = snapshot.data!;
            var atasan = consultation.data()?.containsKey('atasan')
                ? consultation['atasan']
                : 'Atasan tidak tersedia';
            var topic = consultation['topic'];
            var priority = consultation['priority'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Atasan: $atasan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Topik: "$topic"',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Prioritas: $priority',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: priority == "Rendah" ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 1, color: Colors.black),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('consultations')
                        .doc(consultationId)
                        .collection('messages')
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var messages = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          var sender = message['sender'];
                          var text = message['text'];
                          var timestamp = message['timestamp'] as Timestamp;
                          var formattedTime = DateFormat('dd MMM yyyy, hh:mm a')
                              .format(timestamp.toDate());

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.005),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "$sender - \"$text\"",
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.04),
                                  ),
                                ),
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1, color: Colors.black),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Tambahkan komentar/tanggapan baru...",
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        // Implementasikan upload gambar
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: () {
                        // Implementasikan upload file
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        // Implementasikan upload gambar dari galeri
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        // Implementasikan pengiriman pesan baru
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

extension on Object? {
  containsKey(String s) {}
}
