import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsScreen extends StatelessWidget {
  EmergencyContactsScreen({super.key});

  // List of emergency contacts
  final List<Map<String, String>> emergencyContacts = [
    {
      "title": "National Emergency Number (112)",
      "description":
          "Single emergency helpline for police, fire, and ambulance.",
      "number": "112"
    },
    {
      "title": "Police (100)",
      "description": "Report crimes, violence, and other law-and-order issues.",
      "number": "100"
    },
    {
      "title": "Ambulance (102)",
      "description": "Free emergency medical transport.",
      "number": "102"
    },
    {
      "title": "Fire Brigade (101)",
      "description": "Report fire emergencies or gas leaks.",
      "number": "101"
    },
    {
      "title": "Disaster Management (1078)",
      "description":
          "Government helpline for floods, earthquakes, and disasters.",
      "number": "1078"
    },
    {
      "title": "Vandrevala Foundation",
      "description": "24/7 mental health support and suicide prevention.",
      "number": "18602662345"
    },
    {
      "title": "Snehi",
      "description": "Emotional support for depression and anxiety.",
      "number": "9582208181"
    },
    {
      "title": "AASRA",
      "description": "Confidential suicide prevention helpline.",
      "number": "9820466726"
    },
    {
      "title": "iCall",
      "description": "Professional mental health guidance.",
      "number": "9152987821"
    },
    {
      "title": "Women Helpline (181)",
      "description": "Support for domestic violence and harassment.",
      "number": "181"
    },
    {
      "title": "Child Helpline (1098)",
      "description": "Supports abused, abandoned, or distressed children.",
      "number": "1098"
    },
    {
      "title": "Cyber Crime Helpline (1930)",
      "description": "Handles cyber fraud and online harassment.",
      "number": "1930"
    },
    {
      "title": "Senior Citizen Helpline (14567)",
      "description": "Support for elderly individuals in distress.",
      "number": "14567"
    },
  ];

  // Function to launch dialer
  void _callNumber(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),
        backgroundColor: const Color.fromARGB(255, 222, 161, 181), // Pink theme
        foregroundColor: Colors.white,
      ),
      backgroundColor: colorScheme.surface, // Matches dark/light mode
      body: ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts[index];

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.phone, color: Colors.pinkAccent),
              title: Text(
                contact["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(contact["description"]!),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _callNumber(contact["number"]!),
              ),
              onTap: () => _callNumber(contact["number"]!), // Tap to call
            ),
          );
        },
      ),
    );
  }
}
