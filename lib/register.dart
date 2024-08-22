import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartassistant/loginpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  
  // Menyimpan nilai role yang dipilih
  String _selectedRole = 'user'; // Default role
  
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Register user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save additional user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'role': _selectedRole,  // Menyimpan role yang dipilih ke Firestore
      });

      // Navigate to HomePage or LoginPage after registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration failed: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Form
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
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
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: UnderlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Dropdown for Role Selection
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Pilih Role',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: UnderlineInputBorder(),
                      ),
                      value: _selectedRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                      items: <String>['user', 'admin', 'atasan']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Error message
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  // Register Button
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(75, 185, 236, 100),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Link to Login
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Already have an account? Login here'),
                  ),

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
