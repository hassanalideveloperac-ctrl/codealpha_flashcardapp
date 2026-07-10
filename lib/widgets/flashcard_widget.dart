import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onToggleAnswer;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onToggleAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 8,
        shadowColor: const Color(0xFF6C63FF).withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: showAnswer
                  ? [
                const Color(0xFF00B894).withOpacity(0.15),
                const Color(0xFF00B894).withOpacity(0.05),
              ]
                  : [
                const Color(0xFF6C63FF).withOpacity(0.15),
                const Color(0xFF6C63FF).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Container(
            width: double.infinity,
            height: 340,
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: showAnswer
                          ? [const Color(0xFF00B894), const Color(0xFF00C9A7)]
                          : [const Color(0xFF6C63FF), const Color(0xFF8B7BF7)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    showAnswer ? '✧ ANSWER' : '✧ QUESTION',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          showAnswer ? flashcard.answer : flashcard.question,
                          key: ValueKey(showAnswer),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: showAnswer ? 24 : 22,
                            fontWeight: showAnswer ? FontWeight.w600 : FontWeight.w500,
                            height: 1.6,
                            color: showAnswer ? const Color(0xFF00B894) : const Color(0xFF2D2D3F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  elevation: 4,
                  shadowColor: (showAnswer ? const Color(0xFF00B894) : const Color(0xFF6C63FF)).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: onToggleAnswer,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: showAnswer
                              ? [const Color(0xFF00B894), const Color(0xFF00C9A7)]
                              : [const Color(0xFF6C63FF), const Color(0xFF8B7BF7)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            showAnswer ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            showAnswer ? 'Hide Answer' : 'Show Answer',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}