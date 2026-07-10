import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../database/database_helper.dart';
import 'dart:math';

class FlashcardProvider extends ChangeNotifier {
  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  bool _showAnswer = false;
  bool _isLoading = false;

  List<Flashcard> get flashcards => _flashcards;
  int get currentIndex => _currentIndex;
  bool get showAnswer => _showAnswer;
  int get totalCards => _flashcards.length;
  bool get hasCards => _flashcards.isNotEmpty;
  bool get isLoading => _isLoading;

  final DatabaseHelper _db = DatabaseHelper();

  Future<void> loadFlashcards() async {
    _isLoading = true;
    notifyListeners();
    try {
      _flashcards = await _db.getAllFlashcards();
      _currentIndex = _flashcards.isNotEmpty ? 0 : 0;
      _showAnswer = false;
    } catch (e) {
      debugPrint('Error loading flashcards: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addFlashcard(String question, String answer) async {
    _isLoading = true;
    notifyListeners();
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final flashcard = Flashcard(
        id: id,
        question: question,
        answer: answer,
      );
      await _db.insertFlashcard(flashcard);
      await loadFlashcards();
    } catch (e) {
      debugPrint('Error adding flashcard: $e');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _db.updateFlashcard(flashcard);
      await loadFlashcards();
    } catch (e) {
      debugPrint('Error updating flashcard: $e');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteFlashcard(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _db.deleteFlashcard(id);
      await loadFlashcards();
    } catch (e) {
      debugPrint('Error deleting flashcard: $e');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteAllFlashcards() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _db.deleteAllFlashcards();
      await loadFlashcards();
    } catch (e) {
      debugPrint('Error deleting all flashcards: $e');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void toggleAnswer() {
    _showAnswer = !_showAnswer;
    notifyListeners();
  }

  void nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      _currentIndex++;
      _showAnswer = false;
      notifyListeners();
    }
  }

  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _showAnswer = false;
      notifyListeners();
    }
  }

  Flashcard getCurrentCard() {
    if (_flashcards.isEmpty) {
      throw Exception('No flashcards available');
    }
    return _flashcards[_currentIndex];
  }
}