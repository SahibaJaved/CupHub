import 'package:flutter/material.dart';

class EspressoDetailScreen extends StatefulWidget {
  @override
  _EspressoDetailScreenState createState() => _EspressoDetailScreenState();
}

class _EspressoDetailScreenState extends State<EspressoDetailScreen> {
 
  String selectedSize = "Small";
  bool extraShot = false;
  int basePrice = 300;

 
  int get currentPrice {
    int price = basePrice;
    if (selectedSize == "Medium") price += 50;
    if (selectedSize == "Large") price += 100;
    if (extraShot) price += 80;
    return price;
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
                'assets/espresso.png',
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
                        "Espresso",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Text(" 4.9", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

                  SizedBox(height: 25),

                  Text("Customizations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  CheckboxListTile(
                    title: Text("Add Extra Shot (+Rs. 80)", style: TextStyle(fontSize: 15)),
                    value: extraShot,
                    activeColor: Color(0xFF6F4436),
                    onChanged: (val) => setState(() => extraShot = val!),
                    contentPadding: EdgeInsets.zero,
                  ),

                  SizedBox(height: 20),

  
                  Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "Espresso is a full-flavored, concentrated form of coffee that is served in shots. It is made by forcing pressurized hot water through very finely ground coffee beans.",
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),

                  SizedBox(height: 40),

       
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Espresso added to cart!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6F4436),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        "Add to Cart | Rs. $currentPrice",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
}