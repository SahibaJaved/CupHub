import 'package:flutter/material.dart';

class LatteDetailScreen extends StatefulWidget {
  @override
  _LatteDetailScreenState createState() => _LatteDetailScreenState();
}

class _LatteDetailScreenState extends State<LatteDetailScreen> {
 
  String selectedSize = "Small";
  int basePrice = 450;
  int quantity = 1; 
  bool isFavorite = true; 

  
  int get calculatedPrice {
    int pricePerCup = basePrice;
    if (selectedSize == "Medium") pricePerCup = basePrice + 100;
    if (selectedSize == "Large") pricePerCup = basePrice + 200;
    return pricePerCup * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.asset(
                'assets/latte.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.coffee_maker, size: 100, color: Colors.brown),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Latte",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () { if (quantity > 1) setState(() => quantity--); },
                              child: const Icon(Icons.remove, size: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("$quantity", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            GestureDetector(
                              onTap: () { setState(() => quantity++); },
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Text(" 4.8 (230 Reviews)", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text("Coffee Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sizeButton("Small"),
                      _sizeButton("Medium"),
                      _sizeButton("Large"),
                    ],
                  ),
                  
                  const SizedBox(height: 25),
                  const Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "A latte or caffè latte is a milk coffee that boasts a silky layer of foam. It is made up of espresso, steamed milk and a thin layer of frothed milk.",
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.brown,
                          content: Text("Added $quantity $selectedSize Latte to cart! Total: Rs. $calculatedPrice"),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart | Rs. $calculatedPrice",
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
                          ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B4513) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B4513) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected ? [BoxShadow(color: Colors.brown.withOpacity(0.3), blurRadius: 8)] : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}