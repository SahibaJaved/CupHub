import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

<<<<<<< HEAD
  static String _priceLine(Map<String, dynamic> item) {
    final p = item['price'];
    if (p is String) return p;
    return 'Rs. $p';
  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFD8BBA9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Favorites ❤️",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: fav.favorites.isEmpty
                  ? const Center(child: Text("No Favorites"))
                  : ListView.builder(
                      itemCount: fav.favorites.length,
                      itemBuilder: (context, index) {
                        final item = fav.favorites[index];

                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item["image"] as String,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                width: 56,
                                height: 56,
                                color: Colors.grey.shade300,
                                alignment: Alignment.center,
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          title: Text(item["name"] as String),
                          subtitle: Text(_priceLine(item)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
=======
  @override
  Widget build(BuildContext context) {

    final fav = Provider.of<FavoritesProvider>(context);

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Favorites ❤️",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: fav.favorites.isEmpty
                  ? const Center(
                      child: Text("No Favorites"),
                    )
                  : ListView.builder(
                      itemCount: fav.favorites.length,
                      itemBuilder: (context, index) {

                        final item = fav.favorites[index];

                        return ListTile(
                          leading: Image.asset(item["image"]),

                          title: Text(item["name"]),

                          subtitle: Text(
                            "Rs. ${item["price"]}",
                          ),

                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                            onPressed: () {
                              fav.toggleFavorite(item);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
