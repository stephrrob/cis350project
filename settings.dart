import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool enableReminder = true; // Default value for enabling reminders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Enable Reminders'),
                Switch(
                  value: enableReminder,
                  onChanged: (value) async {
                    // Toggle the reminder setting
                    setState(() {
                      enableReminder = value;
                    });

                    // Update user's reminder preference on the backend
                    final success = await updateUserSettings(enableReminder);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: enableReminder
                              ? Text('Reminders enabled.')
                              : Text('Reminders disabled.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update settings. Please try again.'),
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
        Uri.parse('https://your-backend-api.com/update_settings'),
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
