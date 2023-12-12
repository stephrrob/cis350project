import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        Uri.parse('mongodb+srv://robinss3:2601pbnjMONGO@choremate-prod-cluster.zxtvu9f.mongodb.net/?retryWrites=true&w=majority/user_profile'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Populate the text controllers with fetched data
        nameController.text = data['name'];
        emailController.text = data['email'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch user profile data.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please check your network connection.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Update user profile data on the backend
                final updatedName = nameController.text;
                final updatedEmail = emailController.text;

                final success = await updateUserProfile(updatedName, updatedEmail);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile updated successfully.'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update profile. Please try again.'),
                    ),
                  );
                }
              },
              child: Text('Save Profile'),
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
        Uri.parse('mongodb+srv://robinss3:2601pbnjMONGO@choremate-prod-cluster.zxtvu9f.mongodb.net/?retryWrites=true&w=majority/update_profile'),
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
