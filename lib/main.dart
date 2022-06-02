import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/state/bindings/quiz.dart';
import 'package:quiz_app/ui/screens/home.dart';
import 'package:quiz_app/ui/screens/quiz.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: QuizScreen.routeName,
          page: () => const QuizScreen(),
          binding: QuizBinding(),
        )
      ],
      initialRoute: HomeScreen.routeName,
    );
  }
}
