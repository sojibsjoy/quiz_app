import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants/colors.dart';
import 'package:quiz_app/state/controllers/quiz.dart';
import 'package:quiz_app/state/utils/preferences.dart';
import 'package:quiz_app/ui/designs/custom_btn.dart';
import 'package:quiz_app/ui/designs/helper_widgets.dart';

class QuizScreen extends StatefulWidget {
  static String routeName = '/quiz';
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController _quizCon = Get.find<QuizController>();
  int _score = 0;
  int _index = 0;
  String _tappedBtnKey = '';
  bool _isTapped = false;
  bool timerFlag = false;

  Timer? _timer;
  int _time = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_time == 0) {
        setState(() {
          _time = 10;
          gotoNext();
        });
      } else {
        setState(() {
          _time--;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.kPrimaryColor,
      body: SafeArea(
        child: Obx(
          () {
            if (_quizCon.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (!timerFlag) {
                startTimer();
                timerFlag = true;
              }
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 25,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 55,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addText(
                          'Question: ${_index + 1}/${_quizCon.qModel.questions.length}',
                        ),
                        addText('Score: $_score'),
                      ],
                    ),
                  ),
                  Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addText('Time: ${_time}s'),
                        addText(
                          "${_quizCon.qModel.questions[_index].score} Point",
                        ),
                        SizedBox(
                          height: 180,
                          width: 260,
                          child: Image.network(
                            _quizCon.qModel.questions[_index].questionImageUrl,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        addText(
                          _quizCon.qModel.questions[_index].question,
                        ),
                      ],
                    ),
                  ),
                  addHeight(30),
                  Expanded(
                    child: ListView(
                      children: _quizCon
                          .qModel.questions[_index].answers.entries
                          .map((item) {
                        return Column(
                          children: [
                            CustomBtn(
                              btnText: item.value,
                              txtSize: 20,
                              onPressedFn: _isTapped
                                  ? () {}
                                  : () {
                                      _isTapped = true;
                                      _time = 2;
                                      _tappedBtnKey = item.key;
                                      if (item.key ==
                                          _quizCon.qModel.questions[_index]
                                              .correctAnswer) {
                                        _score += _quizCon
                                            .qModel.questions[_index].score;
                                      }
                                      setState(() {});
                                    },
                              btnSize: const Size(310, 40),
                              btnClr: _tappedBtnKey == item.key
                                  ? _quizCon.qModel.questions[_index]
                                              .correctAnswer ==
                                          _tappedBtnKey
                                      ? Colors.green
                                      : Colors.red
                                  : _isTapped
                                      ? _quizCon.qModel.questions[_index]
                                                  .correctAnswer ==
                                              item.key
                                          ? Colors.green
                                          : Colors.white
                                      : Colors.white,
                            ),
                            addHeight(10),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget addText(String txt) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: ConstantColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void gotoNext() {
    if (_quizCon.qModel.questions.length - 1 > _index) {
      _index++;
      _isTapped = false;
      _tappedBtnKey = '';
    } else {
      int highScore = Preference.getHighScore();
      if (highScore < _score) {
        Preference.setHighScore(_score);
      }
      Get.back();
    }
  }
}
