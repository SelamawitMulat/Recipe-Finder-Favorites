class FavoriteModel {
  final String recipeId;
  final bool valueState;

  FavoriteModel({
    required this.recipeId,
    required this.valueState,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      recipeId: json['recipeId']?.toString() ?? '',
      valueState: json['valueState'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'valueState': valueState,
    };
  }
}
