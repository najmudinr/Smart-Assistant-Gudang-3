import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailConsultationPage extends StatefulWidget {
  final String consultationId;

  DetailConsultationPage({required this.consultationId});

  @override
  _DetailConsultationPageState createState() => _DetailConsultationPageState();
}

class _DetailConsultationPageState extends State<DetailConsultationPage> {
  TextEditingController _messageController = TextEditingController();
  String? description;

  @override
  void initState() {
    super.initState();
    _loadDescription();
  }

  void _loadDescription() async {
    DocumentSnapshot consultationSnapshot = await FirebaseFirestore.instance
        .collection('consultations')
        .doc(widget.consultationId)
        .get();

    setState(() {
      description = consultationSnapshot['description'];
    });
  }

  Future<String> getUserName(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedName = prefs.getString('userName_$userId');

    // Jika cachedName ada, kembalikan nilai tersebut, jika tidak cek Firestore
    if (cachedName != null) {
      return cachedName;
    }

    // Jika tidak ada di SharedPreferences, cek Firestore
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        // Ambil nama dari dokumen Firestore
        String name = userDoc['name'] ?? 'Nama tidak tersedia';

        // Simpan di SharedPreferences
        prefs.setString('userName_$userId', name);

        return name;
      } else {
        return 'Nama tidak tersedia';
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return 'Error mengambil nama';
    }
  }


  Future<String> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user currently logged in');
    }
  }

  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    String message = _messageController.text.trim();
    String userId = await getCurrentUserId(); // Dapatkan userId dari user yang login

    await FirebaseFirestore.instance
        .collection('consultations')
        .doc(widget.consultationId)
        .collection('messages')
        .add({
      'senderId': userId,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

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
              .doc(widget.consultationId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var consultationData =
                snapshot.data!.data() as Map<String, dynamic>?;

            var atasanUserId = (consultationData != null &&
                    consultationData.containsKey('atasan'))
                ? consultationData['atasan']
                : null;
            var topic = consultationData != null
                ? (consultationData['topic'] ?? 'Topik tidak tersedia')
                : 'Topik tidak tersedia';
            var priority = consultationData != null
                ? (consultationData['priority'] ?? 'Prioritas tidak tersedia')
                : 'Prioritas tidak tersedia';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: atasanUserId != null
                      ? getUserName(atasanUserId)
                      : Future.value('Atasan tidak tersedia'),
                  builder: (context, atasanSnapshot) {
                    if (atasanSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text(
                        "Nama Atasan: Memuat...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      );
                    } else if (atasanSnapshot.hasError) {
                      return Text(
                        "Nama Atasan: Error",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      );
                    } else {
                      var atasanName =
                          atasanSnapshot.data ?? 'Nama tidak tersedia';
                      return Text(
                        "Nama Atasan: $atasanName",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      );
                    }
                  },
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
                if (description != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Deskripsi: \"$description\"",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('consultations')
                        .doc(widget.consultationId)
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
                          var senderId = message['senderId'];
                          var text = message['text'];
                          var timestamp = message['timestamp'] as Timestamp;
                          var formattedTime = DateFormat('dd MMM yyyy, hh:mm a')
                              .format(timestamp.toDate());

                          return FutureBuilder<String>(
                            future: getUserName(senderId),
                            builder: (context, userNameSnapshot) {
                              if (userNameSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.005),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Memuat nama...",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
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
                              } else if (userNameSnapshot.hasError) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.005),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Error mengambil nama",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
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
                              } else {
                                var userName = userNameSnapshot.data ??
                                    'Nama tidak tersedia';
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.005),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "$userName: $text",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
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
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1, color: Colors.black),
                TextField(
                  controller: _messageController,
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
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
