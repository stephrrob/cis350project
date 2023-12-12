import 'package:flutter/material.dart';
import 'chore_list_item.dart';

class Dashboard extends StatelessWidget {
  final List<Map<String, String>> sampleChores = [
    {
      'choreName': 'Clean the kitchen',
      'assignedTo': 'John',
    },
    {
      'choreName': 'Take out the trash',
      'assignedTo': 'Alice',
    },
    // Add more sample chores here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chore Manager'),
      ),
      body: ListView.builder(
        itemCount: sampleChores.length,
        itemBuilder: (context, index) {
          final chore = sampleChores[index];
          return ChoreListItem(
            choreName: chore['choreName']!,
            assignedTo: chore['assignedTo']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chore/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
