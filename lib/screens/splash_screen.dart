import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
<<<<<<< HEAD
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
=======
  @override
  _SplashScreenState createState() => _SplashScreenState();
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
<<<<<<< HEAD

=======
  
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFFD8BBA9),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/coffee_logo.png', fit: BoxFit.contain),
            ),
          ),

          Positioned(
            top: 60,
=======
     
      backgroundColor: const Color(0xFF2B170F), 
      body: Stack(
        children: [
         
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/coffee_logo.png',
               
                fit: BoxFit.contain, 
              ),
            ),
          ),

        
          Positioned(
            top: 60, 
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/logo.jpeg',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

<<<<<<< HEAD
=======
         
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4A373)),
              ),
            ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
