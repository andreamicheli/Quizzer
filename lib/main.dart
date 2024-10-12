import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:quizzer/Questionnaire.dart';
import 'package:quizzer/addQuestions.dart';
import 'package:quizzer/controllers/formController.dart';
import 'package:quizzer/controllers/questionsController.dart';
import 'package:quizzer/results.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.lazyPut<QuestionsController>(() => QuestionsController());
  Get.lazyPut<FormController>(() => FormController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quizzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/",
            page: () => const HomePage(
                  title: "Quizzer",
                )),
        GetPage(
            name: "/questionnaire/:question",
            page: () => Questionnaire(
                  title: "Quizzer",
                )),
        GetPage(
            name: "/result",
            page: () => Results(
                  title: "Quizzer",
                )),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return addQuestions(title: title);
  }
}
