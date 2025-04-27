import 'package:flutter/material.dart';

class ReadBookScreen extends StatelessWidget {
  const ReadBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read a Book')),
      body: const Center(
        child: Text('Take time to read at least 10 pages.'),
      ),
    );
  }
}
