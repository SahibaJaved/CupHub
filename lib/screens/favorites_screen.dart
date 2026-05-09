import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
}