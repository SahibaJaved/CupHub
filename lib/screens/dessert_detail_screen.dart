import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/coffee_detail_widgets.dart';

class DessertDetailScreen extends StatefulWidget {
  const DessertDetailScreen({super.key, required this.dessert});

  final Map<String, dynamic> dessert;

  @override
  State<DessertDetailScreen> createState() => _DessertDetailScreenState();
}

class _DessertDetailScreenState extends State<DessertDetailScreen> {
  String selectedSize = 'Small';
  int quantity = 1;

  int get basePrice => widget.dessert['price'] as int;

  int get unitPrice {
    int price = basePrice;
    if (selectedSize == 'Medium') price += 50;
    if (selectedSize == 'Large') price += 100;
    return price;
  }

  int get lineTotal => unitPrice * quantity;

  void addToCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);

    cart.addItem(
      CartItem(
        name: widget.dessert['name'] as String,
        image: widget.dessert['image'] as String,
        price: unitPrice.toDouble(),
        quantity: quantity,
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to Cart')));
  }

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoritesProvider>();
    final isFav = fav.isFavorite(widget.dessert);

    return Scaffold(
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8BBA9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => fav.toggleFavorite(widget.dessert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Image.asset(
                    widget.dessert['image'] as String,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Container(
                      height: 200,
                      alignment: Alignment.center,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.cake,
                        size: 72,
                        color: Colors.brown.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.dessert['name'] as String,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.dessert['rating'] != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '★ ${widget.dessert['rating']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Text(
                      widget.dessert['description'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  CoffeeSizeChips(
                    selectedSize: selectedSize,
                    onSizeSelected: (s) => setState(() => selectedSize = s),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 20)),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          CompactAddToCartBar(priceText: 'Rs. $lineTotal', onTap: addToCart),
        ],
      ),
    );
  }
}
