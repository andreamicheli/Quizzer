import 'package:get/get.dart';

class FormController extends GetxController {
  RxBool hasTitle;
  RxInt answerCount;
  RxInt correctAnswer;

  FormController()
      : hasTitle = false.obs,
        answerCount = 1.obs,
        correctAnswer = 0.obs;

  void increment() {
    answerCount.value++;
  }

  void reset() {
    hasTitle.value = false;
    answerCount.value = 1;
    correctAnswer.value = 0;
  }
}
