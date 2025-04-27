import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  // Sample meditation data
  final List<Map<String, dynamic>> meditations = [
    {
      "title": "Mindfulness Meditation",
      "description": "Focus on your breath and be aware of your thoughts.",
      "isFavorite": false,
    },
    {
      "title": "Body Scan Meditation",
      "description": "Bring attention to different parts of your body.",
      "isFavorite": false,
    },
    {
      "title": "Loving-Kindness Meditation",
      "description": "Send love and good wishes to yourself and others.",
      "isFavorite": false,
    },
    {
      "title": "Guided Visualization",
      "description": "Imagine relaxing scenes and peaceful environments.",
      "isFavorite": false,
    },
    {
      "title": "Zen Meditation (Zazen)",
      "description": "Observe thoughts and sensations without attachment.",
      "isFavorite": false,
    },
  ];

  void toggleFavorite(int index) {
    setState(() {
      meditations[index]["isFavorite"] = !meditations[index]["isFavorite"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation Activities"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: meditations.length,
        itemBuilder: (context, index) {
          final meditation = meditations[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                meditation["title"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(meditation["description"]),
              trailing: IconButton(
                icon: Icon(
                  meditation["isFavorite"] ? Icons.star : Icons.star_border,
                  color: meditation["isFavorite"]
                      ? Colors.yellow[700]
                      : Colors.grey,
                ),
                onPressed: () => toggleFavorite(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
