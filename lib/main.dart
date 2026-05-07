import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; 

void main() {
  runApp(CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Coffee Shop App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    
      home: SplashScreen(), 
    );
  }
}