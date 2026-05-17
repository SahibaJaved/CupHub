import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';

import '../data/menu_catalog.dart';
import '../providers/favorites_provider.dart';
import 'dessert_detail_screen.dart';

class DessertsScreen extends StatefulWidget {
  const DessertsScreen({super.key});

  @override
  State<DessertsScreen> createState() => _DessertsScreenState();
=======

class DessertsScreen extends StatefulWidget {
  @override
  _DessertsScreenState createState() => _DessertsScreenState();
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
}

class _DessertsScreenState extends State<DessertsScreen> {
  final TextEditingController _searchController = TextEditingController();

<<<<<<< HEAD
  late List<Map<String, dynamic>> _filteredDesserts;
=======
  final List<Map<String, dynamic>> _allDesserts = [
    {
      "name": "Lava Cake",
      "price": 550,
      "image": 'assets/lava_cake.webp',
      "description": "A warm chocolate cake with a molten chocolate center, served with vanilla ice cream.",
      "rating": "4.8"
    },
    {
      "name": "Cheesecake",
      "price": 650,
      "image": 'assets/cheesecake image.webp',
      "description": "Creamy New York style cheesecake with a buttery graham cracker crust and strawberry topping.",
      "rating": "4.7"
    },
    {
      "name": "Tiramisu",
      "price": 700,
      "image": 'assets/tiramisu.webp',
      "description": "Classic Italian dessert made of coffee-soaked ladyfingers and mascarpone cream.",
      "rating": "4.9"
    },
    {
      "name": "Brownie",
      "price": 350,
      "image": 'assets/brownie_image.webp',
      "description": "Rich, fudgy chocolate brownie topped with walnuts and chocolate drizzle.",
      "rating": "4.5"
    },
  ];

  List<Map<String, dynamic>> _filteredDesserts = [];
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _filteredDesserts = List<Map<String, dynamic>>.from(kDessertCatalog);
=======
    _filteredDesserts = _allDesserts;
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
  }

  void _runFilter(String query) {
    setState(() {
<<<<<<< HEAD
      _filteredDesserts = kDessertCatalog
          .where(
            (item) => (item['name'] as String).toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
=======
      _filteredDesserts = _allDesserts
          .where((item) => item["name"].toLowerCase().contains(query.toLowerCase()))
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8BBA9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Desserts', style: TextStyle(color: Colors.black87)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _runFilter,
              decoration: InputDecoration(
                hintText: 'Search desserts...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredDesserts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = _filteredDesserts[index];
                final fav = context.watch<FavoritesProvider>();
                final isFav = fav.isFavorite(item);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DessertDetailScreen(dessert: item),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                item['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  color: Colors.grey.shade200,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.cake,
                                    size: 48,
                                    color: Colors.brown.shade200,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Material(
                                  color: Colors.white70,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () => fav.toggleFavorite(item),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('Rs. ${item['price']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
=======
      backgroundColor: const Color(0xFFFDF8F5),
      appBar: AppBar(
        title: const Text("Sweet Treats", style: TextStyle(color: Color(0xFF4B2C20), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text("Delicious Desserts", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: "Search desserts...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredDesserts.isNotEmpty
                  ? GridView.builder(
                      itemCount: _filteredDesserts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        final item = _filteredDesserts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DessertDetailScreen(dessert: item),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                    child: Image.asset(item['image'], fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("Rs. ${item['price']}", style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No dessert found!")),
            ),
          ],
        ),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
      ),
    );
  }
}
<<<<<<< HEAD
=======



class DessertDetailScreen extends StatefulWidget {
  final Map<String, dynamic> dessert;
  const DessertDetailScreen({required this.dessert});

  @override
  State<DessertDetailScreen> createState() => _DessertDetailScreenState();
}

class _DessertDetailScreenState extends State<DessertDetailScreen> {
  String selectedSize = "Medium";
  bool isFavorite = false;

  int get calculatedPrice {
    int basePrice = widget.dessert['price'];
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
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                    image: DecorationImage(image: AssetImage(widget.dessert['image']), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.black),
                      onPressed: () => setState(() => isFavorite = !isFavorite),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.dessert['name'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 22),
                          Text(" ${widget.dessert['rating']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Select Serving Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sizeButton("Small"),
                      _sizeButton("Medium"),
                      _sizeButton("Large"),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(widget.dessert['description'], style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5)),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Price", style: TextStyle(color: Colors.grey)),
                          Text("Rs. $calculatedPrice", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D3A26))),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added ${widget.dessert['name']} ($selectedSize) to cart!")),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5D3A26),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text("Buy Now", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5D3A26) : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
