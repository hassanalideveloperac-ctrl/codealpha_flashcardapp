class Flashcard {
  final String id;
  String question;
  String answer;
  DateTime createdAt;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Flashcard copyWith({
    String? question,
    String? answer,
  }) {
    return Flashcard(
      id: id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt,
    );
  }
}