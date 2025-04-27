import 'package:flutter/material.dart';
import 'package:mental_health/screens/activity.dart';
import 'package:mental_health/screens/homescreencontent.dart';
import 'package:mental_health/screens/profilescreen.dart';
import 'package:mental_health/service/auth_service.dart';
import 'package:mental_health/service/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  String _userName = "Profile";

  final List<Widget> _screens = [
    HomeScreenContent(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    var user = await _authService.getCurrentUser();
    if (user != null && user.name.isNotEmpty) {
      setState(() {
        _userName = user.name.split(" ")[0];
      });
    }
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      var user = await _authService.getCurrentUser();
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grading_outlined), label: "Activity"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: _userName),
        ],
      ),
    );
  }
}
