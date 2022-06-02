import 'package:get_storage/get_storage.dart';

class Preference {
  static final prefs = GetStorage();
  static const _highScore = "highScore";

  static int getHighScore() {
    return prefs.read(_highScore) ?? 0;
  }

  static setHighScore(int score) {
    prefs.write(_highScore, score);
  }
}
