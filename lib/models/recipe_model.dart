class RecipeModel {
  final String id;
  final String title;
  final String category;
  final String instructions;
  final String thumbnailUrl;
  final List<String> ingredients;
  final String userNotes;

  RecipeModel({
    required this.id,
    required this.title,
    required this.category,
    required this.instructions,
    required this.thumbnailUrl,
    required this.ingredients,
    required this.userNotes,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedIngredients = [];
    var ingredientsData = json['ingredients'];

    if (ingredientsData is List) {
      parsedIngredients =
          List<String>.from(ingredientsData.map((e) => e.toString()));
    } else if (ingredientsData is String && ingredientsData.isNotEmpty) {
      parsedIngredients =
          ingredientsData.split(',').map((e) => e.trim()).toList();
    }

    // Capture unique identification based on mealName
    String detectedId = json['id']?.toString() ??
        json['_id']?.toString() ??
        json['mealName']?.toString() ??
        json.hashCode.toString();

    return RecipeModel(
      id: detectedId,
      title: json['mealName'] ?? json['title'] ?? '',
      category: json['category'] ?? '',
      instructions: json['instructions'] ?? '',
      thumbnailUrl:
          json['image'] ?? json['thumbnailUrl'] ?? json['imageUrl'] ?? '',
      ingredients: parsedIngredients,
      userNotes: json['userNotes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealName': title,
      'category': category,
      'instructions': instructions,
      'image': thumbnailUrl,
      'ingredients': ingredients,
      'userNotes': userNotes,
    };
  }

  RecipeModel copyWith({
    String? id,
    String? title,
    String? category,
    String? instructions,
    String? thumbnailUrl,
    List<String>? ingredients,
    String? userNotes,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      instructions: instructions ?? this.instructions,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      ingredients: ingredients ?? this.ingredients,
      userNotes: userNotes ?? this.userNotes,
    );
  }
}
