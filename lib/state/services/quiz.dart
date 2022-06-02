import 'package:http/http.dart' as http;
import 'package:quiz_app/constants/strings.dart';

class QuizService {
  static Future<dynamic> getQuestions({required String api}) async {
    var uri = Uri.parse(ConstantStrings.kBaseUrl + api);
    http.Response response = await http.get(uri);
    return response.body;
  }
}
