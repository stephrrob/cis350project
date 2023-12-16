import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user profile data from the backend and populate the text controllers
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      // Replace with your backend API endpoint for fetching user profile data
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/user_profile'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Populate the text controllers with fetched data
        nameController.text = data['name'].toString();
        emailController.text = data['email'].toString();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch user profile data.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'An error occurred. Please check your network connection.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Update user profile data on the backend
                final updatedName = nameController.text;
                final updatedEmail = emailController.text;

                final success =
                    await updateUserProfile(updatedName, updatedEmail);

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully.'),
                    ),
                  );
                } else if (!mounted) {
                  return;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Failed to update profile. Please try again.'),
                    ),
                  );
                }
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to update user profile data on the backend
  Future<bool> updateUserProfile(String name, String email) async {
    try {
      // Replace with your backend API endpoint for updating user profile
      final response = await http.put(
        Uri.parse('http://127.0.0.1:5000/update_profile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email}),
      );

      if (response.statusCode == 200) {
        return true; // Profile update successful
      } else {
        return false; // Profile update failed
      }
    } catch (e) {
      return false; // Error occurred during the update
    }
  }
}
