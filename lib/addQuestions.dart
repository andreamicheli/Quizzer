import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzer/controllers/questionsController.dart';
import 'package:quizzer/qsCard.dart';
import 'package:quizzer/qsForm.dart';
import 'package:quizzer/types.dart';

class addQuestions extends StatelessWidget {
  final String title;

  const addQuestions({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionsController = Get.find<QuestionsController>();
    final size = MediaQuery.of(context).size;

    startQuiz() {
      Get.toNamed("/questionnaire/0");
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Container(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                Text(
                  'Add Questions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                questionInput(),
                SizedBox(height: 40),
                Text(
                  'Current Questions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Obx(
                  () => Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: questionsController.size == 0
                            ? [const Text('No questions')]
                            : [
                                ...questionsController.questions
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int i = entry.key;
                                  var question = entry.value;
                                  return Qscard(question: question, i: i);
                                }).toList(),
                                const SizedBox(height: 60),
                              ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
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
                    questionsController.size > 0 ? Colors.blue : Colors.grey,
                onPressed: questionsController.size > 0 ? startQuiz : null,
                tooltip: 'Start Quiz',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: size.width < Breakpoints.sm
                      ? [
                          const Icon(Icons.play_arrow,
                              size: 20, color: Colors.white),
                          const SizedBox(width: 4),
                          Text("Start",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white)),
                        ]
                      : [
                          const Icon(Icons.play_arrow,
                              size: 40, color: Colors.white),
                          const SizedBox(width: 8),
                          Text("Start",
                              style: TextStyle(
                                  fontSize: 28,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                        ],
                )),
          ),
        ));
  }
}
