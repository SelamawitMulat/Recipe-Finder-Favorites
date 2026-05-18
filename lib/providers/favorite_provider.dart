import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<RecipeModel> _favoriteRecipes = [];

  List<RecipeModel> get favorites => _favoriteRecipes;

  bool isFavorite(RecipeModel recipe) {
    return _favoriteRecipes.any((r) => r.id == recipe.id);
  }

  void toggleFavorite(RecipeModel recipe) {
    final index = _favoriteRecipes.indexWhere((r) => r.id == recipe.id);
    if (index >= 0) {
      _favoriteRecipes.removeAt(index);
    } else {
      _favoriteRecipes.add(recipe);
    }
    notifyListeners();
  }
}
