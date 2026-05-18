import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/recipe_model.dart';

class ApiService {
  // Generates the base collection URL dynamically from your constants
  String get _url => '${ApiConstants.baseUrl}${ApiConstants.recipesEndpoint}';

  /// Fetches the entire feed of recipes from MockAPI
  Future<List<RecipeModel>> getAllRecipes() async {
    try {
      final response = await http.get(Uri.parse(_url)).timeout(
            const Duration(seconds: ApiConstants.connectionTimeoutSeconds),
          );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((recipe) => RecipeModel.fromJson(recipe))
            .toList();
      } else {
        throw Exception('Server returned error code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load server data stream connection: $e');
    }
  }

  /// Sends a PUT request to update a single, specific recipe by its unique ID
  Future<RecipeModel> updateRecipe(
      String id, Map<String, dynamic> updates) async {
    try {
      // Targets the exact structural record URL (e.g., .../recipes/1)
      final individualUrl = '$_url/$id';

      final response = await http.put(
        Uri.parse(individualUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updates),
      );

      if (response.statusCode == 200) {
        return RecipeModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Server rejected the update payload status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network update protocol connection failure: $e');
    }
  }
}
