import 'package:flutter/material.dart';
import 'package:mental_health/screens/DailyReminder/water_reminder.dart';

class DrinkWaterScreen extends StatelessWidget {
  const DrinkWaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drink Water')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Stay hydrated! 8 glasses a day 💧',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WaterReminderScreen()),
                );
              },
              child: const Text('Go to Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
