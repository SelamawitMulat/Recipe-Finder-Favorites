class NoteModel {
  final String mealId;
  final String content;
  final int rating;
  final String lastUpdated;

  NoteModel({
    required this.mealId,
    required this.content,
    required this.rating,
    required this.lastUpdated,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      mealId: json['mealId'] ?? '',
      content: json['content'] ?? '',
      rating: json['rating'] ?? 0,
      lastUpdated: json['lastUpdated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'content': content,
      'rating': rating,
      'lastUpdated': lastUpdated,
    };
  }
}
