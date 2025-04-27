import 'package:flutter/material.dart';
import 'package:mental_health/screens/DailyReminder/gratitudejournalscreen.dart';
import 'package:mental_health/screens/DailyReminder/meditation.dart';
import 'package:mental_health/screens/DailyReminder/musicscreen.dart';
import 'package:mental_health/screens/DailyReminder/readbookscreen.dart';
import 'package:mental_health/screens/DailyReminder/stretchingscreen.dart';
import 'package:mental_health/screens/DailyReminder/walkscreen.dart';
import 'package:mental_health/screens/DailyReminder/water_reminder.dart';
import 'package:mental_health/screens/chatscreen.dart';
import 'package:mental_health/screens/moodscreen/calm_screen.dart';
import 'package:mental_health/screens/moodscreen/energetic_screen.dart';
import 'package:mental_health/screens/moodscreen/focused_screen.dart';
import 'package:mental_health/screens/moodscreen/happy_screen.dart';
import 'package:mental_health/screens/moodscreen/relax_screen.dart';
import 'package:mental_health/screens/notes_screen.dart';
import 'package:mental_health/screens/quiz_option.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  HomeScreenContentState createState() => HomeScreenContentState();
}

class HomeScreenContentState extends State<HomeScreenContent> {
  final List<Map<String, dynamic>> moods = [
    {
      'label': 'Happy',
      'image': 'images/happy.png',
      'screen': HappyMoodScreen()
    },
    {'label': 'Calm', 'image': 'images/calm.png', 'screen': const CalmScreen()},
    {
      'label': 'Relax',
      'image': 'images/relaxation.png',
      'screen': const RelaxMoodScreen()
    },
    {
      'label': 'Energetic',
      'image': 'images/energy.png',
      'screen': const EnergeticScreen()
    },
    {
      'label': 'Focused',
      'image': 'images/focused.png',
      'screen': const FocusScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("How are you feeling today?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildMoodScroll(),
                const SizedBox(height: 20),
                _buildTestCard(context),
                const SizedBox(height: 20),
                _buildNotesCard(context),
                const SizedBox(height: 20),
                Text("Daily Reminder!",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildIndividualTasks(screenWidth),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Replace with your chatbot screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatbotScreen()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 218, 140, 186),
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }

  Widget _buildMoodScroll() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: moods.map((mood) {
          return MoodButton(
            label: mood['label'],
            imagePath: mood['image'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mood['screen']),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context) {
    return _infoCard(
      context,
      title: 'Take a Test',
      description: 'Assess your current mental well-being with a quick test.',
      buttonText: 'Start Test',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TestSelectionScreen()));
      },
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return _infoCard(
      context,
      title: 'Jot down your thoughts!',
      description: 'Take notes, suggest things, share your thoughts!',
      buttonText: 'Open!',
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NotesScreen()));
      },
    );
  }

  Widget _infoCard(BuildContext context,
      {required String title,
      required String description,
      required String buttonText,
      required VoidCallback onPressed}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child:
                ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualTasks(double screenWidth) {
    return Column(
      children: [
        _taskTile(
            "Meditation", "Spend 10 mins meditating", const MeditationScreen()),
        _taskTile("Gratitude Journal", "Write 3 things you are grateful for",
            const GratitudeJournalScreen()),
        _taskTile(
            "Go for a Walk", "Take a 15 min walk outside", const WalkScreen()),
        _taskTile("Drink Water", "Stay hydrated with at least 8 glasses",
            const WaterReminderScreen()),
        _taskTile("Read a Book", "Read at least 10 pages of a book",
            const ReadBookScreen()),
        _taskTile("Listen to Music", "Enjoy some relaxing music",
            const MusicScreen()),
        _taskTile("Stretching", "Do a 5-minute full-body stretch",
            const StretchingScreen()),
      ],
    );
  }

  Widget _taskTile(String title, String description, Widget screen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => screen));
              },
              child: const Text("Complete"),
            ),
          ),
        ],
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;

  const MoodButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 35, height: 35),
            const SizedBox(height: 5),
            Text(label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
