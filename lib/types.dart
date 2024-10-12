class Question {
  final String title;
  final List<String> options;
  final int correct;
  bool isExpanded;
  int answer;

  Question(
      {required this.title,
      required this.options,
      required this.correct,
      this.isExpanded = false,
      this.answer = -1});

  Map toJson() {
    return {"title": title, "options": options, "correct": correct};
  }

  factory Question.fromJson(Map<dynamic, dynamic> json) {
    return Question(
        title: json["title"],
        options: List<String>.from(json["options"]),
        correct: json["correct"] as int);
  }

  void expand() {
    isExpanded = !isExpanded;
  }

  void setAnswer(int answer) {
    this.answer = answer;
  }
}

class Breakpoints {
  static const sm = 640;
  static const md = 768;
}
