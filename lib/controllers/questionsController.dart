import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzer/types.dart';

class QuestionsController extends GetxController {
  final storage = Hive.box("storage");
  RxList<Question> questions;
  RxInt correctAnswers = 0.obs;

  QuestionsController() : questions = <Question>[].obs {
    // Load tasks from storage or initialize with an empty list if none exist
    List<dynamic>? storedQuestions = storage.get('questions');
    if (storedQuestions != null) {
      questions.assignAll(
        storedQuestions.map((question) => Question.fromJson(question)).toList(),
      );
    }
  }

  Question getQuestion(int index) {
    return questions[index];
  }

  void _save() {
    storage.put(
        'questions', questions.map((question) => question.toJson()).toList());
  }

  void add(Question question) {
    questions.add(question);
    _save();
  }

  void expand(Question question) {
    question.expand();
    questions.refresh();
  }

  void setAnswer(Question question, int answer) {
    question.setAnswer(answer);
    questions.refresh();
  }

  void delete(Question question) {
    questions.remove(question);
    questions.refresh();
    _save();
  }

  void correct(Question question, int answer) {
    if (question.answer == question.correct) {
      correctAnswers++;
      print('Correct answer for question: ${question.title}');
    }
  }

  void reset() {
    correctAnswers = 0.obs;
    questions.forEach((question) {
      question.answer = -1;
    });
    questions.refresh();
  }

  int get size => questions.length;
}
