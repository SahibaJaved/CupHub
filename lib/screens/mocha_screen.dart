import 'package:flutter/material.dart';

class MochaDetailedScreen extends StatefulWidget {
  const MochaDetailedScreen({Key? key}) : super(key: key);

  @override
  State<MochaDetailedScreen> createState() => _MochaDetailedScreenState();
}

class _MochaDetailedScreenState extends State<MochaDetailedScreen> {
  String selectedSize = "Medium";
  int basePrice = 550;
  bool isFavorite = false;

  int get calculatedPrice {
    if (selectedSize == "Small") return basePrice - 50;
    if (selectedSize == "Large") return basePrice + 100;
    return basePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        'assets/mocha.webp', 
                       
                        fit: BoxFit.contain, 
                        width: MediaQuery.of(context).size.width * 0.8,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.coffee_maker, size: 100, color: Colors.brown),
                      ),
                    ),
                  ),
                ),
               
                Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              
                Positioned(
                  top: 50,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                      onPressed: () => setState(() => isFavorite = !isFavorite),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Mocha",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange, size: 24),
                          Text(" 4.8", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Coffee with Chocolate",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  
                  const SizedBox(height: 25),
                  const Text("Coffee Size", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sizeButton("Small"),
                      _sizeButton("Medium"),
                      _sizeButton("Large"),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  const Text("About", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    "A delicious blend of rich espresso, steamed milk, and sweet chocolate syrup, topped with a light layer of foam. Perfect for chocolate and coffee lovers.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price", style: TextStyle(color: Colors.grey, fontSize: 16)),
                          Text(
                            "Rs. $calculatedPrice",
                            style: const TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold, 
                              color: Color(0xFF5D3A26)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF5D3A26),
                                  content: Text("Added $selectedSize Mocha to cart!")
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5D3A26),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width * 0.26,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5D3A26) : Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF5D3A26) : Colors.grey.shade300,
          ),
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