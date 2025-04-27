import 'package:flutter/material.dart';

class WalkScreen extends StatelessWidget {
  const WalkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go for a Walk')),
      body: const Center(
        child: Text('Enjoy a 15-minute walk outside!'),
      ),
    );
  }
}
