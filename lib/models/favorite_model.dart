import 'recipe_model.dart';

class FavoriteModel {
  final String id;
  final RecipeModel recipe;
  final DateTime addedAt;

  FavoriteModel({
    required this.id,
    required this.recipe,
    required this.addedAt,
  });

  factory FavoriteModel.fromRecipe(RecipeModel recipe) {
    return FavoriteModel(
      id: recipe.id,
      recipe: recipe,
      addedAt: DateTime.now(),
    );
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as String,
      recipe: RecipeModel.fromJson(json['recipe'] as Map<String, dynamic>),
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipe': recipe.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
