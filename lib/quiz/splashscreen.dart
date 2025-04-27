import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health/quiz/quiz_screen.dart';

class SplashScreen_AN extends StatefulWidget {
  const SplashScreen_AN({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen_AN>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Navigate to HomeScreen after 3 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen_AN()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4A7A3), // Background color
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: Colors.white.withOpacity(0.7),
            spawnMaxRadius: 10,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 20,
            particleCount: 100,
          ),
        ),
        vsync: this,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Static phrase text
                Text(
                  "Over the last two weeks, how often have you been bothered by the following problems?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20), // Space between text and animation

                // Hourglass loading animation at the bottom
                SpinKitHourGlass(
                  color: Colors.white, // Hourglass animation color
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
