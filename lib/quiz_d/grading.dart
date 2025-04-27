import 'package:flutter/material.dart';

String getDepressionSeverity(int score) {
  if (score >= 20) {
    return "Severe Depression";
  } else if (score >= 15) {
    return "Moderately Severe Depression";
  } else if (score >= 10) {
    return "Moderate Depression";
  } else if (score >= 5) {
    return "Mild Depression";
  } else {
    return "Minimal or No Depression";
  }
}

String getDepressionDescription(int score) {
  if (score >= 20) {
    return "You may be experiencing severe depression. It is strongly recommended to seek professional help as soon as possible.";
  } else if (score >= 15) {
    return "Moderately severe depression detected. Consulting a healthcare professional for therapy or treatment is advisable.";
  } else if (score >= 10) {
    return "Moderate depression is present. Consider therapy, counseling, or self-help techniques to improve well-being.";
  } else if (score >= 5) {
    return "Mild depression detected. Engaging in healthy habits, social interactions, and mindfulness exercises can be beneficial.";
  } else {
    return "Minimal or no depression. Continue maintaining a healthy lifestyle and mental well-being!";
  }
}

// Assigns colors based on depression severity
Color getSeverityColor(int score) {
  if (score >= 20) {
    return Colors.red;
  } else if (score >= 15) {
    return Colors.orange;
  } else if (score >= 10) {
    return Colors.yellow;
  } else if (score >= 5) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}
