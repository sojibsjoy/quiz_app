import 'package:get/get.dart';
import 'package:quiz_app/state/controllers/quiz.dart';

class QuizBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(
      () => QuizController(),
    );
  }
}
