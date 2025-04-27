import 'package:flutter/material.dart';
import 'grading.dart';
import 'package:mental_health/quiz_d/quiz_screen.dart';

class ResultScreen_D extends StatelessWidget {
  final int totalScore;

  const ResultScreen_D({super.key, required this.totalScore});

  @override
  Widget build(BuildContext context) {
    String severity = getDepressionDescription(totalScore);
    String description = getDepressionDescription(totalScore);
    double progress = totalScore / 21.0; // Normalized score (0 to 1)

    return Scaffold(
      appBar: AppBar(title: Text("Your Depression Level")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your Total Score: $totalScore",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Progress bar for visual representation
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor:
                  AlwaysStoppedAnimation<Color>(getSeverityColor(totalScore)),
            ),
            SizedBox(height: 20),

            // Anxiety level text with colored emphasis
            Text(
              "Despression Level: $severity",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: getSeverityColor(totalScore),
              ),
            ),
            SizedBox(height: 10),

            // Detailed explanation of anxiety level
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            SizedBox(height: 30),

            // Restart button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreenD()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Restart Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
