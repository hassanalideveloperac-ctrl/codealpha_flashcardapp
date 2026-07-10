import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/flashcard.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const String _key = 'flashcards';

  Future<List<Flashcard>> getAllFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    final List<dynamic> decoded = json.decode(data);
    return decoded.map((item) => Flashcard.fromJson(item)).toList();
  }

  Future<void> saveFlashcards(List<Flashcard> flashcards) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(flashcards.map((f) => f.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  Future<void> insertFlashcard(Flashcard flashcard) async {
    final flashcards = await getAllFlashcards();
    flashcards.insert(0, flashcard);
    await saveFlashcards(flashcards);
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    final flashcards = await getAllFlashcards();
    final index = flashcards.indexWhere((f) => f.id == flashcard.id);
    if (index != -1) {
      flashcards[index] = flashcard;
      await saveFlashcards(flashcards);
    }
  }

  Future<void> deleteFlashcard(String id) async {
    final flashcards = await getAllFlashcards();
    flashcards.removeWhere((f) => f.id == id);
    await saveFlashcards(flashcards);
  }

  Future<void> deleteAllFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}