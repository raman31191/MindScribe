import 'question_model.dart';

final List<Question> questions = [
  Question(
      text:
          "Have you had little interest or pleasure in doing things recently?"),
  Question(text: "Have you been feeling down, depressed, or hopeless?"),
  Question(
      text:
          "Do you have trouble falling or staying asleep, or do you sleep too much?"),
  Question(text: "Do you often feel tired or have little energy?"),
  Question(text: "Have you experienced a poor appetite or been overeating?"),
  Question(
      text:
          "Do you feel bad about yourself, as if you are a failure or have let yourself or your family down?"),
  Question(
      text:
          "Do you have trouble concentrating on tasks, such as reading the newspaper or watching television?"),
  Question(
      text:
          "Have you been moving or speaking so slowly that others have noticed? Or, conversely, have you been feeling so fidgety or restless that you find yourself moving around much more than usual?"),
  Question(
      text:
          "Have you had thoughts that you would be better off dead or of hurting yourself in some way?"),
];

// Answer options with fixed weightage
final Map<String, int> answerOptions = {
  "Not at all": 0,
  "Sometimes": 1,
  "Several Days": 2,
  "Nearly every day": 3,
};
