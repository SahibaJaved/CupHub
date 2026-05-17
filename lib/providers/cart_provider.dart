<<<<<<< HEAD
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/model_cart_item.dart';
import '../models/cart_model.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  StreamSubscription? _cartSubscription;
  
  List<CartItem> _items = [];
  double _totalPrice = 0.0;

  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;

  CartProvider() {
    _initCartStream();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _initCartStream();
    });
  }

  void _initCartStream() {
    _cartSubscription?.cancel();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _cartSubscription = _firestoreService.streamUserCart(userId).listen((cart) {
        if (cart != null) {
          _items = cart.items.map((item) => CartItem(
            name: item.name,
            image: item.assetPath ?? item.imageUrl, // Fallback to imageUrl if assetPath is null
            price: item.price,
            quantity: item.quantity,
          )).toList();
          _totalPrice = cart.subtotal;
        } else {
          _items = [];
          _totalPrice = 0.0;
        }
        notifyListeners();
      });
    } else {
      _items = [];
      _totalPrice = 0.0;
      notifyListeners();
    }
  }

  void addItem(CartItem item) async {
    // Optimistic UI Update
    int index = _items.indexWhere((e) => e.name == item.name && e.price == item.price);
    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _totalPrice += (item.price * item.quantity);
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final cartItemModel = CartItemModel(
      productId: item.name.replaceAll(' ', '_').toLowerCase(), // Generate a simple ID based on name
      name: item.name,
      price: item.price,
      quantity: item.quantity,
      imageUrl: '', 
      assetPath: item.image,
    );
    await _firestoreService.addToCart(userId, cartItemModel);
  }

  void increaseQuantity(int index) async {
    if (index < 0 || index >= _items.length) return;
    final item = _items[index];
    
    // Optimistic UI Update
    item.quantity++;
    _totalPrice += item.price;
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    String productId = item.name.replaceAll(' ', '_').toLowerCase();
    await _firestoreService.updateCartItemQuantity(userId, productId, 1, item.price);
  }

  void decreaseQuantity(int index) async {
    if (index < 0 || index >= _items.length) return;
    final item = _items[index];
    
    // Optimistic UI Update
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.removeAt(index);
    }
    _totalPrice -= item.price;
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    String productId = item.name.replaceAll(' ', '_').toLowerCase();
    await _firestoreService.updateCartItemQuantity(userId, productId, -1, item.price);
  }

  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }
}
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
