import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class RelaxMoodScreen extends StatefulWidget {
  const RelaxMoodScreen({super.key});

  @override
  _RelaxMoodScreenState createState() => _RelaxMoodScreenState();
}

class _RelaxMoodScreenState extends State<RelaxMoodScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  int _relaxLevel = 5;

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
        title: const Text('Relax Mood 🌿'),
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
                colors: const [Colors.blue, Colors.green, Colors.teal],
              ),
            ),

            // === Relaxation Notes ===
            _buildSectionHeader('Write & Let Go ✍️', colorScheme),
            _buildButton('Write a Relaxation Note', Icons.book, () {
              _celebrate();
            }, isDark),
            _buildButton('Reflect on the Day', Icons.psychology, () {
              _celebrate();
            }, isDark),

            // === Soothing Sounds ===
            _buildSectionHeader('Soothing Sounds 🎶', colorScheme),
            _buildActivityCard(
              'Nature Sounds',
              'Listen to calming ocean waves',
              Icons.nature,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Lo-Fi Chill',
              'Soft background beats for relaxation',
              Icons.headphones,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Rainfall Ambience',
              'Gentle rain sounds to ease your mind',
              Icons.cloud,
              () => _celebrate(),
              colorScheme,
            ),

            // === Breathing Exercises ===
            _buildSectionHeader('Deep Breathing 🌬️', colorScheme),
            _buildButton('Start 4-7-8 Breathing', Icons.spa, () {
              _celebrate();
            }, isDark),
            _buildButton('Guided Meditation', Icons.self_improvement, () {
              _celebrate();
            }, isDark),

            // === Self-Care Activities ===
            _buildSectionHeader('Self-Care & Relaxation 💆', colorScheme),
            _buildActivityCard(
              'Gentle Yoga Stretch',
              '5-minute stretching routine',
              Icons.accessibility,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Aromatherapy',
              'Try essential oils for relaxation',
              Icons.local_florist,
              () => _celebrate(),
              colorScheme,
            ),

            // === Mood Reflection ===
            _buildSectionHeader('How Relaxed Do You Feel? 🌊', colorScheme),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deep relaxation helps clear your mind and improve well-being. Take time for yourself. 💙',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                const Text(
                    'Rate your relaxation level after these activities:'),
                Slider(
                  value: _relaxLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _relaxLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      _relaxLevel = value.round();
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

  // ✅ Section header with theme-aware color
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

  // ✅ Button with theme-based background
  Widget _buildButton(
      String text, IconData icon, VoidCallback onPressed, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.tealAccent : Colors.teal[300],
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
      ),
    );
  }

  // ✅ Card background adapts to theme
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
