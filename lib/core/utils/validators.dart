class Validators {
  static bool isValidNote(String? text) {
    return text != null && text.trim().isNotEmpty;
  }
}
