import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/model cart_item.dart';

class DessertDetailScreen extends StatefulWidget {
  final Map<String, dynamic> dessert;

  const DessertDetailScreen({required this.dessert});

  @override
  State<DessertDetailScreen> createState() =>
      _DessertDetailScreenState();
}

class _DessertDetailScreenState
    extends State<DessertDetailScreen> {
  String selectedSize = "Small";
  int quantity = 1;

  int get basePrice => widget.dessert['price'];

  int get totalPrice {
    int price = basePrice;

    if (selectedSize == "Medium") price += 50;
    if (selectedSize == "Large") price += 100;

    return price * quantity;
  }

  void addToCart() {
    final cart = Provider.of<CartProvider>(
      context,
      listen: false,
    );

    int price = basePrice;
    if (selectedSize == "Medium") price += 50;
    if (selectedSize == "Large") price += 100;

    cart.addItem(
      CartItem(
        name: widget.dessert['name'],
        image: widget.dessert['image'],
        price: price.toDouble(),
        quantity: quantity,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to Cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoritesProvider>();
    final isFav = fav.isFavorite(widget.dessert);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dessert['name']),

        actions: [
          IconButton(
            icon: Icon(
              isFav
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              fav.toggleFavorite(widget.dessert);
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.dessert['image'],
                height: 250),

            const SizedBox(height: 10),

            Text(
              widget.dessert['name'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// SIZE
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: ["Small", "Medium", "Large"]
                  .map((size) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedSize == size
                          ? Colors.brown
                          : Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: selectedSize == size
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// QUANTITY
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() => quantity--);
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  "$quantity",
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => quantity++);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(widget.dessert['description']),

            const SizedBox(height: 30),

            /// ADD TO CART
            GestureDetector(
              onTap: addToCart,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20),
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Add to Cart | Rs. $totalPrice",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}