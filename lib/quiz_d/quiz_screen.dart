import 'package:flutter/material.dart';
import 'package:mental_health/quiz_d/quiz_questions/question.dart';
import 'package:mental_health/quiz_d/result.dart';

class QuizScreenD extends StatefulWidget {
  const QuizScreenD({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenD> {
  int currentQuestionIndex = 0;
  int totalScore = 0;

  void answerQuestion(int score) {
    totalScore += score;

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Navigate to result screen after the last question
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen_D(totalScore: totalScore)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Depression Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1} of ${questions.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Display the four fixed answer options
            ...answerOptions.entries.map((entry) {
              return ElevatedButton(
                onPressed: () => answerQuestion(entry.value),
                child: Text(entry.key),
              );
            }),
          ],
        ),
      ),
    );
  }
}
