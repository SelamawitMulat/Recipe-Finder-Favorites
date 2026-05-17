import '../models/recipe_model.dart';
import 'api_service.dart';

/// Wraps API operations specifically for UI domain components matching clean decoupling.
class RecipeService {
  final ApiService _apiService = ApiService();

  Future<List<RecipeModel>> getTrendingItems() async {
    // Defaults search to a fallback profile base to populate feed cleanly
    return await _apiService.searchRecipes('chicken');
  }

  Future<List<RecipeModel>> searchByName(String name) async {
    return await _apiService.searchRecipes(name);
  }

  Future<List<RecipeModel>> searchByCategory(String category) async {
    return await _apiService.getRecipesByCategory(category);
  }

  Future<RecipeModel?> getDetails(String id) async {
    return await _apiService.getRecipeDetails(id);
  }
}
