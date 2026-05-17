import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ================= USERS =================

  /// Creates or updates a user document
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap(), SetOptions(merge: true));
  }

  /// Stream to get user data in real-time
  Stream<UserModel?> streamUser(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snap) {
      if (snap.exists) {
        return UserModel.fromFirestore(snap);
      }
      return null;
    });
  }

  // ================= PRODUCTS =================

  /// Get all available products
  Stream<List<ProductModel>> streamAvailableProducts() {
    return _db
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }

  /// Stream to get products by category
  Stream<List<ProductModel>> streamProductsByCategory(String category) {
    return _db
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }

  // ================= FAVORITES =================

  /// Add to favorites
  Future<void> addFavorite(String userId, String productId) async {
    await _db.collection('users').doc(userId).collection('favorites').doc(productId).set({
      'productId': productId,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove from favorites
  Future<void> removeFavorite(String userId, String productId) async {
    await _db.collection('users').doc(userId).collection('favorites').doc(productId).delete();
  }

  /// Stream user favorites (list of product IDs)
  Stream<List<String>> streamUserFavorites(String userId) {
    return _db.collection('users').doc(userId).collection('favorites').snapshots().map((snap) {
      return snap.docs.map((doc) => doc.id).toList();
    });
  }

  // ================= CARTS =================

  /// Add item to cart
  Future<void> addToCart(String userId, CartItemModel item) async {
    final cartRef = _db.collection('carts').doc(userId);
    final itemRef = cartRef.collection('items').doc(item.productId);

    await _db.runTransaction((transaction) async {
      // 1. Update Cart Subtotal & Time
      transaction.set(
        cartRef,
        {
          'userId': userId,
          'subtotal': FieldValue.increment(item.price * item.quantity),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      // 2. Set or Update Item
      final itemDoc = await transaction.get(itemRef);
      if (itemDoc.exists) {
        transaction.update(itemRef, {
          'quantity': FieldValue.increment(item.quantity),
        });
      } else {
        transaction.set(itemRef, item.toMap());
      }
    });
  }

  /// Update item quantity directly (for increment/decrement from cart screen)
  Future<void> updateCartItemQuantity(String userId, String productId, int change, double unitPrice) async {
    final cartRef = _db.collection('carts').doc(userId);
    final itemRef = cartRef.collection('items').doc(productId);

    await _db.runTransaction((transaction) async {
      final itemDoc = await transaction.get(itemRef);
      if (!itemDoc.exists) return;
      
      int currentQuantity = itemDoc.get('quantity') ?? 1;
      int newQuantity = currentQuantity + change;
      
      if (newQuantity <= 0) {
        // Remove item
        transaction.delete(itemRef);
      } else {
        transaction.update(itemRef, {'quantity': newQuantity});
      }
      
      // Update subtotal (change * unitPrice gives the difference)
      transaction.update(cartRef, {
        'subtotal': FieldValue.increment(change * unitPrice),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  /// Remove item from cart
  Future<void> removeFromCart(String userId, String productId, double itemTotalPrice) async {
    final cartRef = _db.collection('carts').doc(userId);
    final itemRef = cartRef.collection('items').doc(productId);

    await _db.runTransaction((transaction) async {
      transaction.delete(itemRef);
      transaction.set(
        cartRef,
        {
          'subtotal': FieldValue.increment(-itemTotalPrice),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    });
  }

  /// Stream entire cart for user
  Stream<CartModel?> streamUserCart(String userId) {
    return _db.collection('carts').doc(userId).snapshots().asyncMap((cartSnap) async {
      if (!cartSnap.exists) return null;

      final itemsSnap = await cartSnap.reference.collection('items').get();
      final items = itemsSnap.docs.map((doc) => CartItemModel.fromFirestore(doc)).toList();

      return CartModel.fromFirestore(cartSnap, items);
    });
  }

  /// Clear Cart
  Future<void> clearCart(String userId) async {
    final cartRef = _db.collection('carts').doc(userId);
    final itemsSnap = await cartRef.collection('items').get();
    
    final batch = _db.batch();
    for (var doc in itemsSnap.docs) {
      batch.delete(doc.reference);
    }
    batch.set(cartRef, {
      'subtotal': 0.0,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    
    await batch.commit();
  }

  // ================= ORDERS =================

  /// Place an order
  Future<void> placeOrder(OrderModel order) async {
    final orderRef = _db.collection('orders').doc(); // Auto ID
    final batch = _db.batch();

    // 1. Set Order Data
    batch.set(orderRef, order.toMap());

    // 2. Set Order Items Subcollection
    for (var item in order.items) {
      final itemRef = orderRef.collection('order_items').doc(item.productId);
      batch.set(itemRef, item.toMap());
    }

    // 3. Clear Cart upon order
    await batch.commit();
    await clearCart(order.userId);
    
    // 4. Update Admin Dashboard Metrics
    await updateDashboardMetrics(order.totalAmount);
  }

  /// Stream user's orders
  Stream<List<OrderModel>> streamUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snap) async {
      List<OrderModel> orders = [];
      for (var doc in snap.docs) {
        final itemsSnap = await doc.reference.collection('order_items').get();
        final items = itemsSnap.docs.map((itemDoc) => OrderItemModel.fromFirestore(itemDoc)).toList();
        orders.add(OrderModel.fromFirestore(doc, items));
      }
      return orders;
    });
  }

  // ================= ADMIN & METRICS =================

  /// Stream all orders for the Admin Dashboard
  Stream<List<OrderModel>> streamAllOrders() {
    return _db
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snap) async {
      List<OrderModel> orders = [];
      for (var doc in snap.docs) {
        final itemsSnap = await doc.reference.collection('order_items').get();
        final items = itemsSnap.docs.map((itemDoc) => OrderItemModel.fromFirestore(itemDoc)).toList();
        orders.add(OrderModel.fromFirestore(doc, items));
      }
      return orders;
    });
  }

  /// Update an order's status (e.g., from pending -> confirmed -> delivered)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _db.collection('orders').doc(orderId).update({
      'orderStatus': newStatus,
    });
  }

  Future<void> updateDashboardMetrics(double amount) async {
    final metricsRef = _db.collection('dashboard_metrics').doc('summary');
    await metricsRef.set({
      'totalOrders': FieldValue.increment(1),
      'pendingOrders': FieldValue.increment(1),
      'totalRevenue': FieldValue.increment(amount),
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
