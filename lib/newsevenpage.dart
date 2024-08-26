import 'package:flutter/material.dart';

class NewsEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DefaultTabController.of(context)?.animateTo(0);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Berita dan Pengumuman",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 2,
                            color: Colors.teal,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DefaultTabController.of(context)?.animateTo(1);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tanya Komunitas",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 2,
                            color: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // TabBarView untuk menampilkan konten sesuai tab yang dipilih
            Expanded(
              child: TabBarView(
                children: [
                  // Tab "Berita dan Pengumuman"
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 2, // Sesuaikan dengan jumlah data
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.teal,
                                    radius: 20,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Anjung Indrawan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        "Housekeeping · Berita dan Pengumuman",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "What is Lorem Ipsum?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.thumb_up),
                                      SizedBox(width: 4),
                                      Text("5"),
                                      SizedBox(width: 16),
                                      Icon(Icons.comment),
                                      SizedBox(width: 4),
                                      Text("5"),
                                    ],
                                  ),
                                  Text(
                                    "9 jam yang lalu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Tab "Tanya Komunitas"
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3, // Sesuaikan dengan jumlah data
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 20,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Budi Santoso",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "Housekeeping · Tanya Komunitas",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "How to manage time?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Time management tips and strategies are discussed here...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.thumb_up),
                                      SizedBox(width: 4),
                                      Text("10"),
                                      SizedBox(width: 16),
                                      Icon(Icons.comment),
                                      SizedBox(width: 4),
                                      Text("8"),
                                    ],
                                  ),
                                  Text(
                                    "2 jam yang lalu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
