import 'package:flutter/material.dart';
import '../models/model cart_item.dart';

class CartProvider extends ChangeNotifier {

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {

    int index = _items.indexWhere(
      (e) => e.name == item.name && e.price == item.price,
    );

    if (index != -1) {

      _items[index].quantity++;

    } else {

      _items.add(item);

    }

    notifyListeners();
  }

  void increaseQuantity(int index) {

    _items[index].quantity++;

    notifyListeners();
  }

  void decreaseQuantity(int index) {

    if (_items[index].quantity > 1) {

      _items[index].quantity--;

    } else {

      _items.removeAt(index);

    }

    notifyListeners();
  }

  double get totalPrice {

    return _items.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}