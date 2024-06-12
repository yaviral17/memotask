import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:memotask/Apis/api_calls.dart';
import 'package:memotask/Models/mcqModel.dart';

class MCQViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  DateTime? _startTime;
  DateTime? _endTime;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isLoading => _isLoading;
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;

  void setQuestions(List<Question> questions) {
    _questions.clear();
    _questions = questions;
    _startTime = DateTime.now();

    _endTime = null;
    _currentQuestionIndex = 0;

    notifyListeners();
  }

  void setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setStartTime(DateTime time) {
    _startTime = time;
  }

  void setEndTime(DateTime time) {
    _endTime = time;
  }

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }

  void removeQuestion(Question question) {
    _questions.remove(question);
    notifyListeners();
  }

  void updateQuestion(Question question) {
    int index = _questions.indexWhere((element) => element.id == question.id);
    _questions[index] = question;
    notifyListeners();
  }

  void clearQuestions() {
    _questions.clear();
    notifyListeners();
  }

  void initializeQuestions() async {
    if (_questions.isEmpty) {
      fetchNewQuestions();
    } else {
      // Handle error
    }
  }

  void fetchNewQuestions() async {
    // setIsLoading(true);
    // Fetch new questions from API
    Map<String, dynamic> response = await APICalls.getRandomMCQs();
    // log(response.toString());

    // Check if response is successful
    if (response['isSuccess']) {
      List<Question> questions = [];
      for (var question in response['questions']) {
        questions.add(Question.fromAPIJson(question));
      }
      log(questions.length.toString());
      setQuestions(questions);
    } else {
      // Handle error
    }

    // setIsLoading(false);
  }
}
