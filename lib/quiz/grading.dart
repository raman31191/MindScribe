import 'package:flutter/material.dart';

String getAnxietySeverity(int score) {
  if (score >= 15) {
    return "Severe Anxiety";
  } else if (score >= 10) {
    return "Moderate Anxiety";
  } else if (score >= 5) {
    return "Mild Anxiety";
  } else {
    return "Minimal Anxiety";
  }
}

String getAnxietyDescription(int score) {
  if (score >= 15) {
    return "You may be experiencing severe anxiety. It is recommended to consult a healthcare professional for further assessment and support.";
  } else if (score >= 10) {
    return "Moderate anxiety is present. Consider practicing mindfulness, stress management techniques, and seeking professional advice if needed.";
  } else if (score >= 5) {
    return "Mild anxiety detected. Engaging in relaxation exercises and healthy lifestyle habits can help manage stress.";
  } else {
    return "Minimal or no anxiety. Keep maintaining a balanced lifestyle for mental well-being!";
  }
}

// Assigns colors based on anxiety severity
Color getSeverityColor(int score) {
  if (score >= 15) {
    return Colors.red;
  } else if (score >= 10) {
    return Colors.orange;
  } else if (score >= 5) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}
