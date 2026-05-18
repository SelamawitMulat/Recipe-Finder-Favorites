class Helpers {
  static List<String> parseIngredientsString(dynamic rawIngredients) {
    if (rawIngredients is String) {
      return rawIngredients
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (rawIngredients is List) {
      return List<String>.from(rawIngredients);
    }
    return [];
  }
}
