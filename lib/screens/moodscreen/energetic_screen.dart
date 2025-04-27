import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class EnergeticScreen extends StatefulWidget {
  const EnergeticScreen({super.key});

  @override
  _EnergeticScreenState createState() => _EnergeticScreenState();
}

class _EnergeticScreenState extends State<EnergeticScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  int _energyLevel = 7;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Energetic Mood ⚡'),
        backgroundColor: colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.red, Colors.orange, Colors.amber],
              ),
            ),
            _buildSectionHeader('Fuel That Fire! 🔥', colorScheme),
            _buildButton('Start a Power Journal', Icons.flash_on, () {
              _celebrate();
            }, isDark),
            _buildButton('Challenge Yourself', Icons.flag, () {
              _celebrate();
            }, isDark),
            _buildButton('Share Your Wins', Icons.rocket_launch, () {
              _celebrate();
            }, isDark),
            _buildSectionHeader('High-Energy Boosters ⚡', colorScheme),
            _buildActivityCard(
              'Quick Workout',
              '5-minute HIIT session',
              Icons.fitness_center,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Power Pose',
              'Strike a superhero stance for 2 mins',
              Icons.self_improvement,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Shout Your Goals',
              'Say your goal out loud with pride',
              Icons.mic,
              () => _celebrate(),
              colorScheme,
            ),
            _buildSectionHeader('Energize with Music 🎧', colorScheme),
            _buildButton('Play Pump-Up Playlist', Icons.music_note, () {
              _celebrate();
            }, isDark),
            _buildButton('Beat Drop Vibes', Icons.library_music, () {
              _celebrate();
            }, isDark),
            _buildSectionHeader('Why Energy is Power 🔋', colorScheme),
            Text(
              'Harnessing your energetic moments helps build momentum toward bigger goals. Ride the wave!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            const Text('How energized do you feel now?'),
            Slider(
              value: _energyLevel.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _energyLevel.toString(),
              onChanged: (value) {
                setState(() {
                  _energyLevel = value.round();
                  _celebrate();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildButton(
      String text, IconData icon, VoidCallback onPressed, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? Colors.deepOrangeAccent : Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
    ColorScheme colorScheme,
  ) {
    return Card(
      color: colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
