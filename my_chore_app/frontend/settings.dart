import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this import statement
import 'dart:convert'; // Add this import statement

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool enableReminder = true; // Default value for enabling reminders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Enable Reminders'),
                Switch(
                  value: enableReminder,
                  onChanged: (value) async {
                    // Toggle the reminder setting
                    setState(() {
                      enableReminder = value;
                    });

                    // Update user's reminder preference on the backend
                    final success = await updateUserSettings(enableReminder);

                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: enableReminder
                              ? const Text('Reminders enabled.')
                              : const Text('Reminders disabled.'),
                        ),
                      );
                    } else if (!mounted) {
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Failed to update settings. Please try again.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to update user settings on the backend
  Future<bool> updateUserSettings(bool enableReminder) async {
    try {
      // Replace with your backend API endpoint for updating user settings
      final response = await http.put(
        Uri.parse('http://127.0.0.1:5000/update_settings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'enableReminder': enableReminder}),
      );

      if (response.statusCode == 200) {
        return true; // Update successful
      } else {
        return false; // Update failed
      }
    } catch (e) {
      return false; // Error occurred during the update
    }
  }
}
