import 'question_model.dart';

final List<Question> questions = [
  Question(text: "Do you often feel nervous, anxious, or on edge?"),
  Question(text: "Do you struggle to stop or control your worrying?"),
  Question(
      text: "Do you find yourself worrying too much about different things"),
  Question(text: "Do you have trouble relaxing?"),
  Question(text: "Do you feel so restless that it's hard to sit still?"),
  Question(text: "Do you get easily annoyed or irritated?"),
  Question(
      text: "Do you often feel afraid, as if something terrible might happen?"),
];

// Answer options with fixed weightage
final Map<String, int> answerOptions = {
  "Not at all": 0,
  "Sometimes": 1,
  "Several Days": 2,
  "Nearly every day": 3,
};
