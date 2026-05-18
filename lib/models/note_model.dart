class NoteModel {
  final String recipeId;
  final String textContent;

  NoteModel({
    required this.recipeId,
    required this.textContent,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      recipeId: json['recipeId']?.toString() ?? '',
      textContent: json['textContent'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'textContent': textContent,
    };
  }
}
