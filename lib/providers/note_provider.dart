import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class NoteProvider with ChangeNotifier {
  Map<String, NoteModel> _notes = {};
  static const String _storageKey = 'local_recipe_user_notes';

  NoteModel? getNoteForMeal(String mealId) => _notes[mealId];

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawData = prefs.getString(_storageKey);
    if (rawData != null) {
      final Map<String, dynamic> decoded = json.decode(rawData);
      _notes =
          decoded.map((key, value) => MapEntry(key, NoteModel.fromJson(value)));
    }
    notifyListeners();
  }

  Future<void> saveOrUpdateNote(
      String mealId, String content, int rating) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedNote = NoteModel(
      mealId: mealId,
      content: content,
      rating: rating,
      lastUpdated: DateTime.now().toLocal().toString().substring(0, 16),
    );

    _notes[mealId] = updatedNote;

    final rawMap = _notes.map((key, value) => MapEntry(key, value.toJson()));
    await prefs.setString(_storageKey, json.encode(rawMap));
    notifyListeners();
  }

  Future<void> deleteNote(String mealId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_notes.containsKey(mealId)) {
      _notes.remove(mealId);
      final rawMap = _notes.map((key, value) => MapEntry(key, value.toJson()));
      await prefs.setString(_storageKey, json.encode(rawMap));
      notifyListeners();
    }
  }
}
