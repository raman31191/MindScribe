import 'package:flutter/material.dart';
import 'package:mental_health/screens/homescreen.dart';
import 'package:mental_health/screens/splashscreen2.dart';
import 'auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isSignUp = true; // Toggle between SignUp/Login
  bool _isLoading = false;

  String _email = '';
  String _password = '';
  String _name = '';

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        await _authService.signUpUser(_email, _password, _name);
        _showMessage("Sign Up Successful! You are now logged in.",
            navigateToHome: true);
      } else {
        await _authService.logInUser(_email, _password);
        _showMessage("Login Successful!", navigateToHome: true);
      }
    } catch (e) {
      _showMessage(e.toString()); // Show the error message
    }

    setState(() => _isLoading = false);
  }

  void _showMessage(String message, {bool navigateToHome = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );

    if (navigateToHome) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen_(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // Back button added
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ); // Navigates back to the previous screen
          },
        ),
        title: Text(_isSignUp ? "Sign Up" : "Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'images/signup.png',
                  height: 350,
                ),
                const SizedBox(height: 10),
                if (_isSignUp)
                  TextFormField(
                    key: const ValueKey('name'),
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your name' : null,
                    onSaved: (value) => _name = value!,
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.contains('@') ? null : 'Enter a valid email',
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.length >= 6
                      ? null
                      : 'Password must be at least 6 characters',
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _isSignUp ? 'Sign Up' : 'Login',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    setState(() => _isSignUp = !_isSignUp);
                  },
                  child: Text(
                    _isSignUp
                        ? "Already have an account? Login"
                        : "Don't have an account? Sign Up",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
