import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzer/controllers/questionsController.dart';
import 'package:quizzer/types.dart';

class Qscard extends StatelessWidget {
  final Question question;
  QuestionsController questionsController = Get.find<QuestionsController>();
  final int i;

  Qscard({required this.question, required this.i});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Card(
          color: Theme.of(context)
              .colorScheme
              .onPrimary, // Set the background color
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(question.title),
              leading: size.width < Breakpoints.sm
                  ? null
                  : Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          i.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
              trailing: size.width < Breakpoints.sm
                  ? PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('Question $i'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('Delete'),
                            leading: Icon(Icons.delete_outline),
                            onTap: () => questionsController.delete(question),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('Expand'),
                            leading: Icon(question.isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more),
                            onTap: () => questionsController.expand(question),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              {questionsController.delete(question)},
                          child: Icon(Icons.delete_outline),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () =>
                              {questionsController.expand(question)},
                          child: Icon(question.isExpanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                        ),
                      ],
                    )),
        ),
        if (question.isExpanded)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 5, 16.0, 5),
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer, //
              child: Column(
                children: question.options.isEmpty
                    ? [const Text('no options added')]
                    : question.options
                        .map((option) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                title: Center(child: Text(option)),
                                trailing: Icon(question.correct ==
                                        question.options.indexOf(option)
                                    ? Icons.check_circle
                                    : Icons.close),
                              ),
                            ))
                        .toList(),
              ),
            ),
          )
      ],
    );
  }
}
