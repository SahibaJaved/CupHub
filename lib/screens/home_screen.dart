import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';

import '../data/menu_catalog.dart';
import '../providers/favorites_provider.dart';

import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'desserts_screen.dart';
import 'coffee_detail_screen.dart';
import 'profile.dart';

import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  late List<Map<String, dynamic>> _filteredCoffees;
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _filteredCoffees = List<Map<String, dynamic>>.from(kCoffeeCatalog);
  }

  String _timeGreeting() {
    final h = DateTime.now().hour;
    if (h >= 5 && h < 12) return 'Good morning ☕';
    if (h >= 12 && h < 17) return 'Good afternoon ☕';
    if (h >= 17 && h < 21) return 'Good evening ☕';
    return 'Good night ☕';
=======
    _filteredCoffees = _allCoffees;
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
  }

  void _runFilter(String query) {
    setState(() {
<<<<<<< HEAD
      _filteredCoffees = kCoffeeCatalog
          .where(
            (coffee) => (coffee['name'] as String).toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
=======
      _filteredCoffees = _allCoffees
          .where((c) => c["name"].toLowerCase().contains(query.toLowerCase()))
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
          .toList();
    });
  }

<<<<<<< HEAD
  void _openCoffee(Map<String, dynamic> coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CoffeeDetailScreen(coffee: coffee)),
    );
  }

  PreferredSizeWidget? _homeAppBar(BuildContext context) {
    if (_currentIndex != 0) return null;
    final w = MediaQuery.sizeOf(context).width;
    final fontSize = w < 340 ? 15.0 : (w < 400 ? 17.0 : 20.0);
    return AppBar(
      backgroundColor: const Color(0xFFD8BBA9),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        _timeGreeting(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black87,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    final favProvider = Provider.of<FavoritesProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          TextField(
            controller: _searchController,
            onChanged: _runFilter,
            decoration: InputDecoration(
              hintText: "Search coffee...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("COFFEE")),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DessertsScreen()),
                  );
                },
                child: const Text("DESSERTS"),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              itemCount: _filteredCoffees.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final coffee = _filteredCoffees[index];
                final isFav = favProvider.isFavorite(coffee);

                return GestureDetector(
                  onTap: () => _openCoffee(coffee),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              favProvider.toggleFavorite(coffee);
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(
                              coffee['image'] as String,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => Icon(
                                Icons.local_cafe,
                                size: 56,
                                color: Colors.brown.shade200,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          coffee['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(coffee['price'] as String),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const FavoritesScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
=======

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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: _homeAppBar(context),
      body: SafeArea(top: _currentIndex != 0, child: _getPage()),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
