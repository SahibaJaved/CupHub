import 'package:flutter/material.dart';
import 'desserts_screen.dart';
import 'cappuccino.dart'; 
import 'mocha_screen.dart'; 
import 'americano.dart';
import 'espresso.dart';
import 'latte.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "COFFEE";
  final TextEditingController _searchController = TextEditingController();

 
  final List<Map<String, dynamic>> _allCoffees = [
    {"name": "Cappuccino", "price": "Rs. 499", "image": 'assets/cappuccino.png'},
    {"name": "Mocha", "price": "Rs. 550", "image": 'assets/mocha.webp'},
    {"name": "Americano", "price": "Rs. 350", "image": 'assets/americano.png'},
    {"name": "Espresso", "price": "Rs. 499", "image": 'assets/espresso.png'},
    {"name": "Latte", "price": "Rs. 450", "image": 'assets/latte.png'},
  ];

  List<Map<String, dynamic>> _filteredCoffees = [];

  @override
  void initState() {
    super.initState();
    _filteredCoffees = _allCoffees;
  }

  void _runFilter(String query) {
    setState(() {
      _filteredCoffees = _allCoffees
          .where((c) => c["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  void _navigateToCoffeeScreen(String coffeeName) {
    Widget nextScreen;
    
    switch (coffeeName) {
      case "Cappuccino":
        nextScreen = CappuccinoDetailScreen(); 
        break;
      case "Mocha":
        nextScreen = MochaDetailedScreen();
        break;
      case "Americano":
        nextScreen = AmericanoDetailScreen();
        break;
      case "Espresso":
        nextScreen = EspressoDetailScreen();
        break;
      case "Latte":
        nextScreen = LatteDetailScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => nextScreen)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF8F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good Morning!", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Text("Coffee Lover", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(backgroundColor: Colors.brown[100], radius: 25, child: Icon(Icons.person)),
                ],
              ),
              SizedBox(height: 25),
              
            
              TextField(
                controller: _searchController,
                onChanged: _runFilter,
                decoration: InputDecoration(
                  hintText: "Search your coffee...",
                  prefixIcon: Icon(Icons.search, color: Color(0xFF5D3A26)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
              
              SizedBox(height: 25),
              Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
             
              Row(
                children: ["COFFEE", "DESSERTS"].map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: _selectedCategory == cat,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = cat);
                        if (cat == "DESSERTS") {
                          Navigator.push(context, MaterialPageRoute(builder: (c) => DessertsScreen()));
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: 20),
              
             
              Expanded(
                child: _filteredCoffees.isNotEmpty 
                ? GridView.builder(
                  itemCount: _filteredCoffees.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    childAspectRatio: 0.8, 
                    crossAxisSpacing: 15, 
                    mainAxisSpacing: 15
                  ),
                  itemBuilder: (context, index) {
                    final coffee = _filteredCoffees[index];
                    return GestureDetector(
                      onTap: () => _navigateToCoffeeScreen(coffee['name']),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05), 
                              blurRadius: 10, 
                              offset: Offset(0, 5)
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                          
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  coffee['image'], 
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => 
                                      Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                ),
                              ),
                            ),
                            Text(coffee['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(coffee['price'], style: TextStyle(color: Color(0xFF5D3A26))),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                )
                : Center(child: Text("No coffee found!")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}