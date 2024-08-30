import 'package:flutter/material.dart';

class TeamworkManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Teamwork Management',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Teamwork Structure',
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 600 ? 18.0 : 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('No'),
                          ),
                          DataColumn(
                            label: Text('Nama'),
                          ),
                          DataColumn(
                            label: Text('Posisi'),
                          ),
                          DataColumn(
                            label: Text('Deskripsi'),
                          ),
                          DataColumn(
                            label: Text('Ide Project'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          4,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${index + 1}')),
                              DataCell(Text('Nama')),
                              DataCell(Text('Posisi')),
                              DataCell(Text('Deskripsi')),
                              DataCell(Text('Ide Project')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Aksi untuk tombol tambah teamwork
          },
          backgroundColor: Colors.orange,
          icon: Icon(Icons.add),
          label: Text("Tambah Teamwork"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
