import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<RecipeModel> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedCategory = 'All';

  List<RecipeModel> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchHomeRecipes(
      {String search = '', String category = 'All'}) async {
    _isLoading = true;
    _errorMessage = '';
    _selectedCategory = category;
    notifyListeners();

    try {
      if (category != 'All' && search.isEmpty) {
        _recipes = await _apiService.getRecipesByCategory(category);
      } else {
        String query = search.isEmpty ? 'chicken' : search;
        _recipes = await _apiService.searchRecipes(query);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<RecipeModel?> fetchDetailedRecipe(String id) async {
    try {
      return await _apiService.getRecipeDetails(id);
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return null;
    }
  }
}
