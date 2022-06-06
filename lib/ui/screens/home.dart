import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/state/utils/preferences.dart';
import 'package:quiz_app/ui/designs/custom_btn.dart';
import 'package:quiz_app/ui/designs/helper_widgets.dart';
import 'package:quiz_app/ui/screens/quiz.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                ),
                const Text(
                  "Quiz",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addHeight(30),
                Text(
                  "Highscore\n${Preference.getHighScore()} Point",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addHeight(30),
                CustomBtn(
                  btnText: 'Start',
                  txtSize: 30,
                  onPressedFn: () => Get.toNamed(QuizScreen.routeName)!.then(
                    (value) => setState(() {}),
                  ),
                  btnSize: const Size(250, 50),
                  btnClr: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
