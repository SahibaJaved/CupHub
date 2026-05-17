import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String? assetPath;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.assetPath,
  });

  factory CartItemModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CartItemModel(
      productId: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 1,
      imageUrl: data['imageUrl'] ?? '',
      assetPath: data['assetPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      if (assetPath != null) 'assetPath': assetPath,
    };
  }
}

class CartModel {
  final String userId;
  final double subtotal;
  final DateTime updatedAt;
  final List<CartItemModel> items;

  CartModel({
    required this.userId,
    required this.subtotal,
    required this.updatedAt,
    required this.items,
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc, List<CartItemModel> items) {
    Map data = doc.data() as Map<String, dynamic>;
    return CartModel(
      userId: doc.id,
      subtotal: (data['subtotal'] ?? 0).toDouble(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subtotal': subtotal,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
