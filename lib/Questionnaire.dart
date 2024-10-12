import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:quizzer/controllers/questionsController.dart';
import 'package:quizzer/types.dart';

class Questionnaire extends StatelessWidget {
  final String title;

  final _formKey = GlobalKey<FormBuilderState>();
  late final int currentQuestionIndex;
  late final Question currentQuestion;
  final QuestionsController questionsController =
      Get.find<QuestionsController>();

  Questionnaire({Key? key, required this.title}) : super(key: key) {
    final param = Get.parameters["question"];
    currentQuestionIndex = int.tryParse(param ?? '') ?? 0;
    currentQuestion = questionsController.getQuestion(currentQuestionIndex);
  }

  setAnswer(int answerIndex) {
    questionsController.setAnswer(currentQuestion, answerIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void submit() {
      if (currentQuestion.answer >= 0 &&
          currentQuestion.answer < currentQuestion.options.length - 1) {
        questionsController.correct(currentQuestion, currentQuestion.answer);
      }
      if (currentQuestionIndex < questionsController.size - 1) {
        Get.toNamed('/questionnaire/${currentQuestionIndex + 1}');
      } else {
        Get.toNamed('/result');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(children: [
            SizedBox(height: size.width < Breakpoints.sm ? 10 : 40),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              child: Text(
                currentQuestion.title,
                style: size.width < Breakpoints.sm
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: size.width < Breakpoints.sm ? 10 : 40),
            SizedBox(
              width: size.width < Breakpoints.sm
                  ? 300
                  : size.width < Breakpoints.md
                      ? 500
                      : 800,
              child: SingleChildScrollView(
                child: FormBuilderRadioGroup(
                  name: 'answer',
                  onChanged: (int? value) {
                    if (value as int >= 0) setAnswer(value);
                  },
                  orientation: OptionsOrientation.vertical,
                  options: currentQuestion.options
                      .asMap()
                      .entries
                      .map((entry) => FormBuilderFieldOption(
                          value: entry.key,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${entry.key + 1}. ${entry.value}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          )))
                      .toList(),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButtonLocation: size.width > Breakpoints.md
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: size.width < Breakpoints.sm ? 60 : 80,
        width: size.width < Breakpoints.sm ? 100 : 160,
        child: Obx(
          () => FloatingActionButton(
            backgroundColor:
                currentQuestion.answer >= 0 ? Colors.blue : Colors.grey,
            onPressed: () {
              if (currentQuestion.answer >= 0) {
                submit();
              }
            },
            tooltip: 'Start Quiz',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: size.width < Breakpoints.sm
                  ? [
                      const Icon(Icons.play_arrow,
                          size: 20, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                          currentQuestionIndex < questionsController.size - 1
                              ? "Next"
                              : "Results",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white)),
                    ]
                  : [
                      const Icon(Icons.play_arrow,
                          size: 40, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        currentQuestionIndex < questionsController.size - 1
                            ? "Next"
                            : "Results",
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
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

//ADD BUTTON CHANGES BASED ON ANSWER
//NOT WORKING FOR ONLY ONE QS, CHECK THAT
class AnswerFormController extends GetxController {}
