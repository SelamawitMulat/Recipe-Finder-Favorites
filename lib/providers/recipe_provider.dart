// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<RecipeModel> _allRecipes = [];
  List<RecipeModel> _filteredRecipes = [];

  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<RecipeModel> get recipes => _filteredRecipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = ''; // Clear out old error state at the beginning of a retry
    notifyListeners();
    try {
      _allRecipes = await _recipeService.getRecipes();
      await Future.delayed(
          const Duration(seconds: 5)); // Keep for your screenshots
      _applyFilters();
      _errorMessage =
          ''; // FIXED: Wipes it completely clean (no blank space) on success!
    } catch (e) {
      print("❌ DATABASE FETCH ERROR DETAILS: $e");
      _errorMessage =
          "Failed to load recipes. Please check your internet connection.";
      _allRecipes = <RecipeModel>[];
      _filteredRecipes =
          <RecipeModel>[]; // Ensure filtered lists are empty on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void searchRecipes(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    _filteredRecipes = _allRecipes.where((recipe) {
      final matchesCategory =
          _selectedCategory == 'All' || recipe.category == _selectedCategory;
      final matchesSearch = recipe.title.toLowerCase().contains(_searchQuery) ||
          recipe.instructions.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
    notifyListeners();
  }

  void updateRecipeInList(RecipeModel updated) {
    final allIdx = _allRecipes.indexWhere((r) => r.id == updated.id);
    if (allIdx != -1) {
      _allRecipes[allIdx] = updated;
    }

    final filteredIdx = _filteredRecipes.indexWhere((r) => r.id == updated.id);
    if (filteredIdx != -1) {
      _filteredRecipes[filteredIdx] = updated;
      notifyListeners();
    }
  }

  Future<bool> saveRecipeNotes(String recipeId, String newNotes) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedRecipe =
          await _recipeService.updateRecipeNotes(recipeId, newNotes);
      updateRecipeInList(updatedRecipe);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      final targetIdx = _allRecipes.indexWhere((r) => r.id == recipeId);
      if (targetIdx != -1) {
        final locallyUpdatedRecipe =
            _allRecipes[targetIdx].copyWith(userNotes: newNotes);
        updateRecipeInList(locallyUpdatedRecipe);
        _isLoading = false;
        notifyListeners();
        return true;
      }
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteRecipeNotes(String recipeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _recipeService.updateRecipeNotes(recipeId, '');
    } catch (e) {
      debugPrint('Sync bypass: $e');
    }

    final targetIdx = _allRecipes.indexWhere((r) => r.id == recipeId);
    if (targetIdx != -1) {
      final locallyUpdatedRecipe =
          _allRecipes[targetIdx].copyWith(userNotes: '');
      updateRecipeInList(locallyUpdatedRecipe);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
