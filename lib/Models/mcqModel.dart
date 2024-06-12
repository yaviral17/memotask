class Question {
  String id;
  String question;
  List options;
  String answer;
  Difficulty difficulty;
  QuestionStatus status;
  DateTime? viewedAt;
  DateTime? answeredAt;
  String? selectedAnswer;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    this.status = QuestionStatus.notAnswered,
    required this.difficulty,
    this.selectedAnswer,
  });

  factory Question.fromAPIJson(Map<String, dynamic> json) {
    List options = json['incorrectAnswers'];
    options.add(json['correctAnswer']);
    return Question(
      id: json['id'],
      question: json['question']['text'],
      options: options,
      answer: json['correctAnswer'],
      status: questionStatusMap[json['status']] ?? QuestionStatus.notAnswered,
      difficulty: difficultyMap[json['difficulty']] ?? Difficulty.easy,
    );
  }

  factory Question.fromFireStoreJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
      status: questionStatusMap[json['status']] ?? QuestionStatus.notAnswered,
      difficulty: difficultyMap[json['difficulty']] ?? Difficulty.easy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
      'status': questionStatusStringMap[status]!,
      'difficulty': difficultyStringMap[difficulty]!,
    };
  }

  void setViewedAt(DateTime time) {
    viewedAt = time;
  }

  void setAnsweredAt(DateTime time) {
    answeredAt = time;
  }

  void setStatus(QuestionStatus newStatus) {
    status = newStatus;
  }

  @override
  String toString() {
    return 'Question: $question\nOptions: $options\nAnswer: $answer\nDifficulty: $difficulty\nStatus: $status\n';
  }
}

/// This Dart code snippet defines a `Question` class that represents a question with options and an
/// answer. It also includes a `QuestionStatus` enum to track the status of a question (whether it's not
/// answered, answered correctly, or answered wrongly).
enum QuestionStatus { notAnswered, answeredCorrect, answeredWrong }

Map<String, QuestionStatus> questionStatusMap = {
  'notAnswered': QuestionStatus.notAnswered,
  'answeredCorrect': QuestionStatus.answeredCorrect,
  'answeredWrong': QuestionStatus.answeredWrong,
};

Map<QuestionStatus, String> questionStatusStringMap = {
  QuestionStatus.notAnswered: 'notAnswered',
  QuestionStatus.answeredCorrect: 'answeredCorrect',
  QuestionStatus.answeredWrong: 'answeredWrong',
};

/// This code snippet defines an `enum Difficulty` that represents different levels of difficulty: easy,
/// medium, and hard. It also includes two maps:
enum Difficulty { easy, medium, hard }

Map<String, Difficulty> difficultyMap = {
  'easy': Difficulty.easy,
  'medium': Difficulty.medium,
  'hard': Difficulty.hard,
};

Map<Difficulty, String> difficultyStringMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
