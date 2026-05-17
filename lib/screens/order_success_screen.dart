import 'package:flutter/material.dart';
import 'order_tracking_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFC68E5C),

      body: SafeArea(

        child: Stack(

          children: [

            /// BACK BUTTON
            Positioned(
              top: 10,
              left: 10,

              child: CircleAvatar(
                backgroundColor: const Color(0xFF4B2C20),

                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            /// MAIN CONTENT
            Center(

              child: SingleChildScrollView(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    /// LOGO
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/logo.jpeg",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Icon(
                      Icons.local_shipping,
                      size: 100,
                      color: Color(0xFF5D3A26),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Thank You For Your Order!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2C20),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Wait For The Call",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2C20),
                      ),
                    ),

                    const SizedBox(height: 60),

                    /// TRACK BUTTON
                    SizedBox(

                      width: 280,
                      height: 55,

                      child: ElevatedButton(

                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OrderTrackingScreen(),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B2C20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: const Text(
                          "TRACK YOUR ORDER",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}