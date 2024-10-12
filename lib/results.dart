import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzer/controllers/questionsController.dart';

class Results extends StatelessWidget {
  final questionsController = Get.find<QuestionsController>();
  final String title;
  late int totalCorrect;

  Results({Key? key, required this.title}) : super(key: key) {
    totalCorrect = questionsController.correctAnswers.value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Your total number of correct answers is:',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(totalCorrect.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  questionsController.reset();
                  Get.toNamed('/');
                },
                child: Text('Homepage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
