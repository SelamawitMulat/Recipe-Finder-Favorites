import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  String _editingText = '';
  bool _isSaving = false;

  String get editingText => _editingText;
  bool get isSaving => _isSaving;

  void initializeNoteText(String initialText) {
    _editingText = initialText;
  }

  void updateEditingText(String text) {
    _editingText = text;
    notifyListeners();
  }

  void setSavingState(bool value) {
    _isSaving = value;
    notifyListeners();
  }

  void clearControllerState() {
    _editingText = '';
    _isSaving = false;
  }
}
