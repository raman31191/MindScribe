import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  _FocusScreenState createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  int _focusLevel = 5;

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
        title: const Text('Focus Mode 🧘‍♂️'),
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
                colors: const [Colors.blue, Colors.green, Colors.indigo],
              ),
            ),

            // === Get in the Zone Section ===
            _buildSectionHeader('Get in the Zone 🔬', colorScheme),
            _buildButton('Write a Focus Note', Icons.edit_note, () {
              _celebrate();
            }, isDark),
            _buildButton('Set a Goal for Today', Icons.check_circle_outline,
                () {
              _celebrate();
            }, isDark),
            _buildButton('Silence Notifications', Icons.notifications_off, () {
              _celebrate();
            }, isDark),

            // === Tools & Tips Section ===
            _buildSectionHeader('Tools to Stay Productive ⚙️', colorScheme),
            _buildActivityCard(
              'Pomodoro Timer',
              '25-min work + 5-min break cycles',
              Icons.timer,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'To-Do List',
              'Break tasks into small wins',
              Icons.list_alt,
              () => _celebrate(),
              colorScheme,
            ),
            _buildActivityCard(
              'Binaural Beats',
              'Science-backed focus music',
              Icons.headphones,
              () => _celebrate(),
              colorScheme,
            ),

            // === Planner Section ===
            _buildSectionHeader('Plan for Deep Work 🧠', colorScheme),
            _buildButton('Add Session to Calendar', Icons.calendar_month, () {
              _celebrate();
            }, isDark),
            _buildButton('Launch Focus Playlist', Icons.music_note, () {
              _celebrate();
            }, isDark),

            // === Reflection Section ===
            _buildSectionHeader('Track Your Progress 📈', colorScheme),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Focused time leads to flow state — the zone where productivity and creativity thrive.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                const Text('Rate how focused you feel right now:'),
                Slider(
                  value: _focusLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _focusLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      _focusLevel = value.round();
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
          backgroundColor: isDark ? Colors.indigoAccent : Colors.indigo[300],
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
