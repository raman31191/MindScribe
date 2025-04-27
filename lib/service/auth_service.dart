import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mental_health/constants.dart';

class AuthService {
  late Client client;
  late Account account;

  AuthService() {
    client = Client()
      ..setEndpoint(AppwriteConstants.endpoint) // Your Appwrite endpoint
      ..setProject(AppwriteConstants.databaseId); // Your Project ID

    account = Account(client);
  }

  // Sign Up User
  Future<void> signUpUser(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      print('User registered successfully');

      // Automatically log in the user after signup
      await logInUser(email, password);
    } catch (e) {
      print('Error: $e');
      throw Exception('Sign-up failed. Please try again.');
    }
  }

  // Sign In User
  Future<void> logInUser(String email, String password) async {
    try {
      final session = await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      print('User signed in: ${session.$id}');
    } catch (e) {
      print('Error: $e');
      if (e.toString().contains('invalid credentials')) {
        throw Exception('Invalid email or password. Please try again.');
      } else {
        throw Exception('Login failed. Please try again later.');
      }
    }
  }

  // Get User Info
  Future<User?> getCurrentUser() async {
    try {
      return await account.get();
    } catch (e) {
      print('No active session found: $e');
      return null;
    }
  }

  // Logout User
  Future<void> logoutUser() async {
    try {
      await account.deleteSession(sessionId: 'current');
      print('User logged out successfully');
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
