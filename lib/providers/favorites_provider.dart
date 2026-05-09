import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> item) {
    final index = _favorites.indexWhere(
      (e) => e['name'] == item['name'],
    );

    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(item);
    }

    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> item) {
    return _favorites.any((e) => e['name'] == item['name']);
  }
}