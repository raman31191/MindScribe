import 'package:flutter/material.dart';

class GratitudeJournalScreen extends StatelessWidget {
  const GratitudeJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gratitude Journal')),
      body: const Center(
        child: Text('Write 3 things you are grateful for today.'),
      ),
    );
  }
}
