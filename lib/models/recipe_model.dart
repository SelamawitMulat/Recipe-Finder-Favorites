class RecipeModel {
  final String id;
  final String title;
  final String category;
  final String thumbnailUrl;
  final String? instructions;
  final List<String> ingredients;

  RecipeModel({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnailUrl,
    this.instructions,
    required this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        if (measure != null && measure.toString().trim().isNotEmpty) {
          parsedIngredients.add(
              "${measure.toString().trim()} ${ingredient.toString().trim()}");
        } else {
          parsedIngredients.add(ingredient.toString().trim());
        }
      }
    }

    return RecipeModel(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? '',
      category: json['strCategory'] ?? json['strArea'] ?? 'General',
      thumbnailUrl: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'],
      ingredients: parsedIngredients,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': title,
      'strCategory': category,
      'strMealThumb': thumbnailUrl,
      'strInstructions': instructions,
    };
  }
}
