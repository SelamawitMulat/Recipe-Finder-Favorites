import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe_model.dart';
import '../models/favorite_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<FavoriteModel> _favorites = [];
  static const String _storageKey = 'local_favorites_list';

  List<FavoriteModel> get favorites => _favorites;

  bool isFavorite(String mealId) {
    return _favorites.any((fav) => fav.id == mealId);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getStringList(_storageKey);
    if (rawData != null) {
      _favorites = rawData
          .map((item) => FavoriteModel.fromJson(json.decode(item)))
          .toList();
    } else {
      _favorites = [];
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(RecipeModel recipe) async {
    final prefs = await SharedPreferences.getInstance();
    if (isFavorite(recipe.id)) {
      _favorites.removeWhere((fav) => fav.id == recipe.id);
    } else {
      _favorites.add(FavoriteModel.fromRecipe(recipe));
    }

    final encoded = _favorites.map((fav) => json.encode(fav.toJson())).toList();
    await prefs.setStringList(_storageKey, encoded);
    notifyListeners();
  }
}
