import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class HappyMoodScreen extends StatefulWidget {
  const HappyMoodScreen({super.key});

  @override
  _HappyMoodScreenState createState() => _HappyMoodScreenState();
}

class _HappyMoodScreenState extends State<HappyMoodScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  int _happinessLevel = 5; // Slider value for happiness reflection

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _celebrate() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Happy Mood 🎉'),
        backgroundColor: const Color.fromARGB(255, 252, 219, 219),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Confetti Animation
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.yellow, Colors.orange, Colors.pink],
              ),
            ),

            // Amplify Your Joy Section
            _buildSectionHeader('Celebrate Your Happiness! 🎉'),
            _buildButton('Write a Gratitude Note', Icons.edit, () {
              _celebrate();
              // Navigate to a gratitude journal screen
            }),
            _buildButton('Share with a Friend', Icons.share, () {
              _celebrate();
              // Implement sharing functionality
            }),
            _buildButton('Post a Positive Quote', Icons.auto_graph_outlined,
                () {
              _celebrate();
              // Show a dialog with a random positive quote
            }),

            // Energize Your Mood Section
            _buildSectionHeader('Keep the Good Vibes Flowing 🌟'),
            _buildActivityCard(
                'Dance Break', '3-minute guided dance video', Icons.music_video,
                () {
              _celebrate();
              // Play a dance video
            }),
            _buildActivityCard('Random Act of Kindness',
                'Compliment someone today', Icons.favorite, () {
              _celebrate();
              // Show kindness ideas
            }),
            _buildActivityCard('Creative Outlet',
                'Draw something that makes you smile', Icons.brush, () {
              _celebrate();
              // Open a drawing canvas
            }),

            // Future Happiness Planner
            _buildSectionHeader('Plan More Joy Ahead 📅'),
            _buildButton('Add to Calendar', Icons.calendar_today, () {
              _celebrate();
              // Open calendar to schedule an event
            }),
            _buildButton('Play Happiness Playlist', Icons.music_note, () {
              _celebrate();
              // Open a music playlist
            }),

            // Reflect & Reinforce Section
            _buildSectionHeader('Why This Feeling Matters 🌈'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Did you know? Celebrating small joys trains your brain to focus on positivity. Keep it up!',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 20), // Properly placed inside the Column
                Text('Rate how empowered you feel after these activities:'),
                Slider(
                  value: _happinessLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _happinessLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      _happinessLevel = value.round();
                      _celebrate();
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800]),
      ),
    );
  }

  // Helper method to build buttons
  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[200],
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
      ),
    );
  }

  // Helper method to build activity cards
  Widget _buildActivityCard(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.orangeAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
