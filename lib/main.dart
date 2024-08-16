import 'package:flutter/material.dart';
import 'package:smartassistant/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring Gudang & Pengantongan',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(239, 175, 12, 100))
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}