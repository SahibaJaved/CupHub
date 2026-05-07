import 'package:flutter/material.dart';

class AmericanoDetailScreen extends StatefulWidget {
  @override
  _AmericanoDetailScreenState createState() => _AmericanoDetailScreenState();
}

class _AmericanoDetailScreenState extends State<AmericanoDetailScreen> {
  
  String selectedSize = "Small";
  int quantity = 1;
  int basePrice = 350;

  int get totalPrice {
    int sizePrice = basePrice;
    if (selectedSize == "Medium") sizePrice += 50;
    if (selectedSize == "Large") sizePrice += 100;
    return sizePrice * quantity;
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
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.favorite_border, color: Colors.brown, size: 30),
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
              padding: EdgeInsets.all(20),
              child: Image.asset(
                'assets/americano.png',
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, st) => Icon(Icons.coffee, size: 100, color: Colors.brown),
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
                        "Americano",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Text(" 4.5", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 25),
                  
                 
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

                  SizedBox(height: 30),

                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          _quantityBtn(Icons.remove, () {
                            if (quantity > 1) setState(() => quantity--);
                          }),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("$quantity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          _quantityBtn(Icons.add, () {
                            setState(() => quantity++);
                          }),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "Caffè Americano is prepared by diluting an espresso with hot water, giving it a similar strength to, but different flavor from, traditionally brewed coffee.",
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),

                  SizedBox(height: 40),

                 
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added $quantity $selectedSize Americano to Cart")),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF6F4436),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart | Rs. $totalPrice",
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
      onTap: () => setState(() => selectedSize = label),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF8B4513) : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Color(0xFF8B4513) : Colors.grey.shade300),
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

  
  Widget _quantityBtn(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }
}