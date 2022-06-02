import 'dart:convert';

import 'package:get/get.dart';
import 'package:quiz_app/constants/strings.dart';
import 'package:quiz_app/state/models/question.dart';
import 'package:quiz_app/state/services/quiz.dart';

class QuizController extends GetxController {
  RxBool isLoading = true.obs;
  late QuestionModel qModel;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading(true);
    try {
      var response = await QuizService.getQuestions(
        api: ConstantStrings.kQuizAPI,
      );
      qModel = QuestionModel.fromJson(jsonDecode(response));
    } finally {
      isLoading(false);
    }
  }
}
