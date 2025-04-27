import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CalmScreen extends StatefulWidget {
  const CalmScreen({super.key});

  @override
  _CalmScreenState createState() => _CalmScreenState();
}

class _CalmScreenState extends State<CalmScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  int _calmLevel = 6;

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _soothe() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Calm Mood 🧘‍♂️'),
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
                colors: const [Colors.lightBlue, Colors.teal, Colors.white],
              ),
            ),
            _buildSectionHeader('Welcome Peace 🕊️', colorScheme),
            _buildButton('Write a Calming Note', Icons.edit_note, () {
              _soothe();
            }, isDark),
            _buildButton('Guided Breathing Exercise', Icons.air, () {
              _soothe();
            }, isDark),
            _buildButton('Light a Virtual Candle', Icons.local_florist, () {
              _soothe();
            }, isDark),
            _buildSectionHeader('Peaceful Practices 🌿', colorScheme),
            _buildActivityCard(
              'Nature Sounds',
              'Stream relaxing rain or ocean sounds',
              Icons.nature,
              () => _soothe(),
              colorScheme,
            ),
            _buildActivityCard(
              '5-Minute Body Scan',
              'Progressively relax your muscles',
              Icons.spa,
              () => _soothe(),
              colorScheme,
            ),
            _buildActivityCard(
              'Soothing Visuals',
              'Watch peaceful animations',
              Icons.landscape_rounded,
              () => _soothe(),
              colorScheme,
            ),
            _buildSectionHeader('Calm Tunes 🎶', colorScheme),
            _buildButton('Play Soothing Playlist', Icons.library_music, () {
              _soothe();
            }, isDark),
            _buildButton('Zen Ambience', Icons.music_note, () {
              _soothe();
            }, isDark),
            _buildSectionHeader('Why Calmness Counts 💆‍♀️', colorScheme),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Taking time to slow down restores balance to your mind and body. Calmness is clarity.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                const Text('How calm do you feel right now?'),
                Slider(
                  value: _calmLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _calmLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      _calmLevel = value.round();
                      _soothe();
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
          backgroundColor: isDark ? Colors.tealAccent[700] : Colors.teal[300],
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
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
