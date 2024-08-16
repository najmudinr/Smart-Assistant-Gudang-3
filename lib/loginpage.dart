import 'package:flutter/material.dart';
import 'package:smartassistant/homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer to push content down
                  SizedBox(height: screenHeight * 0.1),

                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/logopg.png', height: screenHeight * 0.05),
                      Image.asset('assets/logogd.png', height: screenHeight * 0.05),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Title
                  Text(
                    'SMART ASSISTANT GUDANG & PENGANTONGAN AREA III',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Background Image
                  Image.asset(
                    'assets/bgdb.jpeg',
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.25,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Form
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama Pengguna',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: UnderlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Login Button
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        // logic here
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(75, 185, 236, 100),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Footer
                  Text(
                    '@2024. Gudang & Pengantongan III. Petrokimia Gresik',
                    style: TextStyle(
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Spacer to push content up from bottom
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
