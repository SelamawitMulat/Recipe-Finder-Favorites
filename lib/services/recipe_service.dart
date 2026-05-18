import '../models/recipe_model.dart';
import 'api_service.dart';

class RecipeService {
  final ApiService _apiService = ApiService();

  Future<List<RecipeModel>> getRecipes() async {
    try {
      return await _apiService.getAllRecipes();
    } catch (e) {
      throw Exception('Failed to fetch recipes: $e');
    }
  }

  Future<RecipeModel> updateRecipeNotes(String id, String notes) async {
    try {
      return await _apiService.updateRecipe(id, {'userNotes': notes});
    } catch (e) {
      throw Exception('Failed to update notes: $e');
    }
  }
}
