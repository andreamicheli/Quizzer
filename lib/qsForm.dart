import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:quizzer/controllers/formController.dart';
import 'package:quizzer/controllers/questionsController.dart';
import 'package:quizzer/types.dart';

class questionInput extends StatelessWidget {
  final questionsController = Get.find<QuestionsController>();
  static final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController titleController = TextEditingController();
  final formController = Get.find<FormController>();

  _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      List<String> options = [];
      _formKey.currentState!.value.forEach((key, value) {
        if (key.startsWith('answer')) {
          options.add(value);
        }
      });
      // final newQuestion = new Question(title: _formKey.currentState!.value['title'], options: options, correct: correct)
      final newQuestion = new Question(
          title: titleController.text,
          options: options,
          correct: formController.correctAnswer.value);
      _formKey.currentState?.reset();
      questionsController.add(newQuestion);
      formController.reset();
    }
  }

  correctAnswer(int index) {
    formController.correctAnswer.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    titleController.addListener(() {
      if (titleController.text.isNotEmpty) {
        formController.hasTitle.value = true;
      } else {
        formController.hasTitle.value = false;
      }
    });

    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            style: TextStyle(fontWeight: FontWeight.bold),
            controller: titleController,
            name: 'title',
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.onSecondary,
              hintText: 'Text of the Question',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: size.width < Breakpoints.sm ? 0 : 20),
          Obx(() {
            return formController.hasTitle.value
                ? Column(
                    children: List.generate(
                      formController.answerCount.value,
                      (index) => Column(children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                groupId: 'answer',
                                name: 'answer$index',
                                decoration: InputDecoration(
                                  fillColor:
                                      Theme.of(context).colorScheme.onSecondary,
                                  hintText: 'Text of the Answer',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (index == formController.answerCount.value - 1)
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () => {
                                        formController.increment(),
                                      },
                                  child: Icon(Icons.add)),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                style: size.width < Breakpoints.sm
                                    ? ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      )
                                    : null,
                                onPressed: () => {
                                      correctAnswer(index),
                                    },
                                child: Icon(
                                    formController.correctAnswer.value != index
                                        ? Icons.check_circle_outline_outlined
                                        : Icons.check_circle)),
                          ],
                        )
                      ]),
                    ),
                  )
                : Container();
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
