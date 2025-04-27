import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 219, 219),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Daily Activity",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard("Take 5 Cleansing Breaths",
                      "Mindful Activity", "1 min", Icons.star, Colors.yellow),
                  _buildActivityCard("Find Peace Amid Chaos", "The Wake Up",
                      "3-7 min", Icons.radio, Colors.purple),
                  _buildActivityCard("Playfulness", "Today's Meditation",
                      "3-20 min", Icons.wb_sunny, Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String subtitle, String time,
      IconData icon, Color iconColor) {
    return Card(
      color: Colors.blueAccent.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 40),
        title: Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        subtitle: Text("$subtitle\n$time",
            style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.more_vert, color: Colors.white),
      ),
    );
  }
}
