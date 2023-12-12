import 'package:flutter/material.dart';

class ChoreListItem extends StatelessWidget {
  final String choreName;
  final String assignedTo;

  ChoreListItem({required this.choreName, required this.assignedTo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          // Implement checkbox logic here
          // You can use a stateful widget and manage the checkbox state
        ),
        title: Text(choreName),
        subtitle: Text('Assigned to: $assignedTo'),
        onTap: () {
          // Implement onTap logic for chore details or editing
          // You can navigate to the chore details screen here
        },
      ),
    );
  }
}
