import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mental_health/screens/homescreen.dart';
//import 'package:mental_health/screens/startingscreen.dart';

class SplashScreen_ extends StatefulWidget {
  const SplashScreen_({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen_>
    with TickerProviderStateMixin {
  final List<String> quotes = [
    "“If you’re always trying to be normal, you will never know how amazing you can be.”\n— Maya Angelou",
    "“You, yourself, as much as anybody in the entire universe, deserve your love and affection.”\n— Buddha",
    "“Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.”\n— Buddha",
    "“Happiness can be found even in the darkest of times, if one only remembers to turn on the light.”\n— J.K. Rowling",
    "“You don’t have to control your thoughts. You just have to stop letting them control you.”\n— Dan Millman",
    "“Not until we are lost do we begin to understand ourselves.”\n— Henry David Thoreau",
    "“Promise me you’ll always remember: You’re braver than you believe, and stronger than you seem, and smarter than you think.”\n— A.A. Milne",
    "“Tough times never last, but tough people do.”\n— Robert H. Schuller",
    "“Do what you can, with what you have, where you are.”\n— Theodore Roosevelt",
    "“The greatest glory in living lies not in never falling, but in rising every time we fall.”\n— Nelson Mandela",
  ];

  late String randomQuote;

  @override
  void initState() {
    super.initState();
    randomQuote = getRandomQuote();

    // Navigate to StartingScreen after 5 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  String getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
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
                // Display the random quote at the top
                Text(
                  randomQuote,
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
