import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/coffee_detail_widgets.dart';

/// Latte-style layout for any coffee from [kCoffeeCatalog].
class CoffeeDetailScreen extends StatefulWidget {
  const CoffeeDetailScreen({super.key, required this.coffee});

  final Map<String, dynamic> coffee;

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  String selectedSize = 'Small';
  int quantity = 1;
  bool extraShot = false;

  bool get _showExtraShot => widget.coffee['extraShot'] == true;

  int get _extraShotPrice => (widget.coffee['extraShotPrice'] as int?) ?? 80;

  int get unitPrice {
    int p = widget.coffee['basePrice'] as int;
    if (selectedSize == 'Medium') {
      p += (widget.coffee['mediumAdd'] as int?) ?? 0;
    }
    if (selectedSize == 'Large') {
      p += (widget.coffee['largeAdd'] as int?) ?? 0;
    }
    if (_showExtraShot && extraShot) {
      p += _extraShotPrice;
    }
    return p;
  }

  int get lineTotal => unitPrice * quantity;

  Map<String, dynamic> get _favPayload => {
    'name': widget.coffee['name'],
    'price': widget.coffee['price'],
    'image': widget.coffee['image'],
  };

  void addToCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addItem(
      CartItem(
        name: widget.coffee['name'] as String,
        image: widget.coffee['image'] as String,
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
    final isFav = fav.isFavorite({'name': widget.coffee['name']});

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
            onPressed: () => fav.toggleFavorite(_favPayload),
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
                    widget.coffee['image'] as String,
                    height: 200,
                    errorBuilder: (_, _, _) => Container(
                      height: 200,
                      alignment: Alignment.center,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.local_cafe,
                        size: 72,
                        color: Colors.brown.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.coffee['name'] as String,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Text(
                      widget.coffee['description'] as String,
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
                  if (_showExtraShot) ...[
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      title: Text('Extra shot (+Rs. $_extraShotPrice)'),
                      value: extraShot,
                      onChanged: (v) => setState(() => extraShot = v ?? false),
                    ),
                  ],
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
