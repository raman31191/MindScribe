import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:mental_health/constants.dart';
import 'package:mental_health/service/waterdata_service.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class WaterReminderScreen extends StatefulWidget {
  const WaterReminderScreen({super.key});

  @override
  _WaterReminderScreenState createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  int totalIntake = 0;
  final int goal = 4000;

  final Client client = Client()
      .setEndpoint(AppwriteConstants.endpoint)
      .setProject(AppwriteConstants.databaseId);

  late final Account account;
  late final WaterService waterService;
  late final models.User user;

  // Confetti controller
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    account = Account(client);
    waterService = WaterService(client);
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _init();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      print("🌊 Initializing account...");
      user = await account.get();
      print("✅ User ID: ${user.$id}");
      await _loadIntake();
    } catch (e) {
      print("❌ Error during initialization: $e");
    }
  }

  Future<void> _loadIntake() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final intake = await waterService.getTodayWaterIntake(user.$id, today);
      print("📊 Fetched today's intake: $intake ml");
      setState(() => totalIntake = intake);
    } catch (e) {
      print("❌ Error loading intake: $e");
    }
  }

  Future<void> _addWater() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await waterService.logWaterIntake(user.$id, today, 250);
      print("💧 Logged 250ml of water for $today");
      _confettiController.play(); // Trigger confetti
      await _loadIntake();
    } catch (e) {
      print("❌ Error logging water: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (totalIntake / goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Reminder"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  foregroundPainter: CircleProgressPainter(progress),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$totalIntake ml",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            "Goal: $goal ml",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _addWater,
                  icon: const Icon(Icons.local_drink),
                  label: const Text("Add 250ml"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          // 🎉 Confetti
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 20,
            colors: const [
              Colors.teal,
              Colors.green,
              Colors.blue,
              Colors.purple,
              Colors.amber,
            ],
          ),
        ],
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 15.0;
    final radius = (size.width / 2) - strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    final angle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
