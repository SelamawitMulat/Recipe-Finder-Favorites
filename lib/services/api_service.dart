import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/recipe_model.dart';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<RecipeModel>> searchRecipes(String query) async {
    try {
      final response =
          await client.get(Uri.parse('${ApiConstants.searchEndpoint}$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] == null) return [];
        return (data['meals'] as List)
            .map((meal) => RecipeModel.fromJson(meal))
            .toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }

  Future<List<RecipeModel>> getRecipesByCategory(String category) async {
    try {
      final response = await client
          .get(Uri.parse('${ApiConstants.filterEndpoint}$category'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] == null) return [];
        return (data['meals'] as List)
            .map((meal) => RecipeModel.fromJson(meal))
            .toList();
      } else {
        throw Exception('Failed to load recipes by category');
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }

  Future<RecipeModel?> getRecipeDetails(String id) async {
    try {
      final response =
          await client.get(Uri.parse('${ApiConstants.lookupEndpoint}$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] == null || (data['meals'] as List).isEmpty)
          return null;
        return RecipeModel.fromJson(data['meals'][0]);
      } else {
        throw Exception('Failed to fetch item details');
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }
}
