import 'package:firebase_core/firebase_core.dart';
/* import 'package:flutter/foundation.dart';
import 'package:smartassistant/homepage.dart'; */
import 'package:flutter/material.dart';
import 'package:smartassistant/firebase_options.dart';
import 'package:smartassistant/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );  // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Assistant',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(239, 175, 12, 100))
      ),
      home:/*   kDebugMode ? HomePage() :   */LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}