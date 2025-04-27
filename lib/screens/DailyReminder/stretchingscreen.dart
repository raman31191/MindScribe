import 'package:flutter/material.dart';

class StretchingScreen extends StatelessWidget {
  const StretchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stretching')),
      body: const Center(
        child: Text('Do a full-body stretch for 5 minutes.'),
      ),
    );
  }
}
