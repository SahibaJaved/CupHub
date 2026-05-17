import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _filteredCoffees = List<Map<String, dynamic>>.from(kCoffeeCatalog);
  }

  String _timeGreeting() {
    final h = DateTime.now().hour;
    if (h >= 5 && h < 12) return 'Good morning ☕';
    if (h >= 12 && h < 17) return 'Good afternoon ☕';
    if (h >= 17 && h < 21) return 'Good evening ☕';
    return 'Good night ☕';
  }

  void _runFilter(String query) {
    setState(() {
      _filteredCoffees = kCoffeeCatalog
          .where(
            (coffee) => (coffee['name'] as String).toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
