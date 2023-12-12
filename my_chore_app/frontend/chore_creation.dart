import 'package:flutter/material.dart';

class ChoreCreation extends StatefulWidget {
  @override
  _ChoreCreationState createState() => _ChoreCreationState();
}

class _ChoreCreationState extends State<ChoreCreation> {
  TextEditingController choreNameController = TextEditingController();
  TextEditingController assignedToController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Chore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: choreNameController,
              decoration: InputDecoration(labelText: 'Chore Name'),
            ),
            TextField(
              controller: assignedToController,
              decoration: InputDecoration(labelText: 'Assigned To'),
            ),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(labelText: 'Deadline'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Extract chore details from text controllers
                final choreName = choreNameController.text;
                final assignedTo = assignedToController.text;
                final deadline = deadlineController.text;

                // Basic input validation
                if (choreName.isNotEmpty && assignedTo.isNotEmpty && deadline.isNotEmpty) {
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
                    if (response.statusCode == 201) {
                      // Chore created successfully, you can show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Chore created successfully.'),
                        ),
                      );
                      // Clear input fields
                      choreNameController.clear();
                      assignedToController.clear();
                      deadlineController.clear();
                    } else {
                      // Handle other response statuses (e.g., validation errors)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to create chore. Please try again.'),
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle network or server errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An error occurred. Please check your network connection.'),
                      ),
                    );
                  }
                } else {
                  // Handle input validation errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                }
              },
              child: Text('Create Chore'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send a chore creation request to the backend
  Future<http.Response> createChore(Map<String, dynamic> choreData) async {
    final url = Uri.parse('mongodb+srv://robinss3:2601pbnjMONGO@choremate-prod-cluster.zxtvu9f.mongodb.net/?retryWrites=true&w=majority/create_chore'); // Replace with your backend URL
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(choreData),
    );

    return response;
  }
}
