import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  StreamSubscription? _favoritesSubscription;

  // We will store just the product IDs from Firestore
  List<String> _favoriteIds = [];
  
  // We can still keep the full map locally for UI rendering if the UI depends on it
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  FavoritesProvider() {
    _initFavoritesStream();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _initFavoritesStream();
    });
  }

  void _initFavoritesStream() {
    _favoritesSubscription?.cancel();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _favoritesSubscription = _firestoreService.streamUserFavorites(userId).listen((favoriteIds) {
        _favoriteIds = favoriteIds;
        // Clean up the local _favorites list based on synced IDs
        _favorites.removeWhere((item) {
          String productId = item['name'].replaceAll(' ', '_').toLowerCase();
          return !_favoriteIds.contains(productId);
        });
        notifyListeners();
      });
    } else {
      _favoriteIds = [];
      _favorites.clear();
      notifyListeners();
    }
  }

  void toggleFavorite(Map<String, dynamic> item) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    String productId = item['name'].replaceAll(' ', '_').toLowerCase();

    if (userId == null) {
      // Local mode
      final index = _favorites.indexWhere((e) => e['name'] == item['name']);
      if (index != -1) {
        _favorites.removeAt(index);
      } else {
        _favorites.add(item);
      }
      notifyListeners();
      return;
    }

    // Connected to Firestore
    final index = _favorites.indexWhere((e) => e['name'] == item['name']);
    if (index != -1) {
      // It exists locally, so remove it
      _favorites.removeAt(index);
      notifyListeners(); // Optimistic UI update
      await _firestoreService.removeFavorite(userId, productId);
    } else {
      // Does not exist, add it
      _favorites.add(item);
      notifyListeners(); // Optimistic UI update
      await _firestoreService.addFavorite(userId, productId);
    }
  }

  bool isFavorite(Map<String, dynamic> item) {
    String productId = item['name'].replaceAll(' ', '_').toLowerCase();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    if (userId == null) {
      return _favorites.any((e) => e['name'] == item['name']);
    } else {
      // If we're logged in, rely on the synced list of IDs or the local optimist array
      return _favoriteIds.contains(productId) || _favorites.any((e) => e['name'] == item['name']);
    }
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}