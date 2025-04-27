import 'package:flutter/material.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listen to Music')),
      body: const Center(
        child: Text('Relax and enjoy your favorite tunes 🎶'),
      ),
    );
  }
}
