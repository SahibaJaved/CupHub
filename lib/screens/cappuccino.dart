import 'package:flutter/material.dart';

class CappuccinoDetailScreen extends StatefulWidget {
  @override
  _CappuccinoDetailScreenState createState() => _CappuccinoDetailScreenState();
}

class _CappuccinoDetailScreenState extends State<CappuccinoDetailScreen> {
  
  String selectedSize = "Small";
  bool isFavorite = false;
  int basePrice = 400;

  
  int get currentPrice {
    if (selectedSize == "Medium") return basePrice + 100;
    if (selectedSize == "Large") return basePrice + 200;
    return basePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                'assets/cappuccino.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.coffee, size: 100, color: Colors.brown),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cappuccino",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Text(" 4.7", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                 
                  Text("Coffee Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sizeButton("Small"),
                      _sizeButton("Medium"),
                      _sizeButton("Large"),
                    ],
                  ),

                  SizedBox(height: 25),

              
                  Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "A cappuccino is an espresso-based coffee drink that is traditionally prepared with double espresso, hot milk, and steamed milk foam on top.",
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),

                  SizedBox(height: 30),

                 
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added $selectedSize Cappuccino to Cart")),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart | Rs. $currentPrice",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _sizeButton(String label) {
    bool isSelected = selectedSize == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = label;
        });
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF8B4513) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}