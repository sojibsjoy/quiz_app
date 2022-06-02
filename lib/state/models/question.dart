import 'dart:convert';

QuestionModel questionModelFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));

class QuestionModel {
  QuestionModel({
    required this.questions,
  });

  List<Question> questions;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );
}

class Question {
  Question({
    required this.question,
    required this.answers,
    required this.questionImageUrl,
    required this.correctAnswer,
    required this.score,
  });

  String question;
  Map<String, dynamic> answers;
  String questionImageUrl;
  String correctAnswer;
  int score;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"] ?? '',
        answers: json["answers"],
        questionImageUrl: json["questionImageUrl"] ?? '',
        correctAnswer: json["correctAnswer"] ?? '',
        score: json["score"] ?? 0,
      );
}
