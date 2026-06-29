import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/user_provider.dart';
import 'package:shop/view/home_screen.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  void _login() async {
    if (_name.text.isEmpty || _email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Fill all the forms')),
      );
      return;
    }

    await Provider.of<UserProvider>(context, listen: false)
        .setUser(_name.text, _email.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // background
         decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff89f7fe), Color(0xff66a6ff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "TechLand\nYou Deserve the Best",
                  
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Glassmorphism for forms
                _buildGlassmorphicBox(
                  child: Column(
                    children: [
      
                      _buildInputField(
                        controller: _name,
                        label: 'Name',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                     
                      _buildInputField(
                        controller: _email,
                        label: 'Email',
                        icon: Icons.email_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // login buttom
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 8,
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  liquid forms widget
  Widget _buildGlassmorphicBox({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }

  
  Widget _buildInputField(
      {required TextEditingController controller,
      required String label,
      required IconData icon}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white70, width: 2),
        ),
      ),
    );
  }
}
