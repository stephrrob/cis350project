import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChoreCreation extends StatefulWidget {
  const ChoreCreation({Key? key}) : super(key: key);
  @override
  ChoreCreationState createState() => ChoreCreationState();
}

class ChoreCreationState extends State<ChoreCreation> {
  TextEditingController choreNameController = TextEditingController();
  TextEditingController assignedToController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Chore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: choreNameController,
              decoration: const InputDecoration(labelText: 'Chore Name'),
            ),
            TextField(
              controller: assignedToController,
              decoration: const InputDecoration(labelText: 'Assigned To'),
            ),
            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(labelText: 'Deadline'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Extract chore details from text controllers
                final choreName = choreNameController.text;
                final assignedTo = assignedToController.text;
                final deadline = deadlineController.text;

                // Basic input validation
                if (choreName.isNotEmpty &&
                    assignedTo.isNotEmpty &&
                    deadline.isNotEmpty) {
                  // Create a map containing chore data
                  final choreData = {
                    'choreName': choreName,
                    'assignedTo': assignedTo,
                    'deadline': deadline,
                  };

                  try {
                    // Send a chore creation request to the backend
                    final response = await createChore(choreData);

                    // Handle success response
                    if (response.statusCode == 201 && mounted) {
                      // Chore created successfully, you can show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Chore created successfully.'),
                        ),
                      );
                      // Clear input fields
                      choreNameController.clear();
                      assignedToController.clear();
                      deadlineController.clear();
                    } else if (!mounted) {
                      return;
                    } else {
                      // Handle other response statuses (e.g., validation errors)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Failed to create chore. Please try again.'),
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle network or server errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'An error occurred. Please check your network connection.'),
                      ),
                    );
                  }
                } else {
                  // Handle input validation errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                }
              }, //onpresed
              child: const Text('Create Chore'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send a chore creation request to the backend
  Future<http.Response> createChore(Map<String, dynamic> choreData) async {
    final url = Uri.parse(
        'http://127.0.0.1:5000/create_chore'); // Replace with your local backend API endpoint for creating chores
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(choreData),
    );

    return response;
  }
}
