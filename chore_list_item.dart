import 'package:flutter/material.dart';

class ChoreListItem extends StatefulWidget {
  final String choreName;
  final String assignedTo;

  ChoreListItem({required this.choreName, required this.assignedTo});

  @override
  _ChoreListItemState createState() => _ChoreListItemState();
}

class _ChoreListItemState extends State<ChoreListItem> {
  bool isCompleted = false; // Checkbox state

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (value) {
            // Update the checkbox state when it's tapped
            setState(() {
              isCompleted = value!;
            });
          },
        ),
        title: Text(widget.choreName),
        subtitle: Text('Assigned to: ${widget.assignedTo}'),
        onTap: () {
          // Navigate to the chore details screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChoreDetailsScreen(
                choreName: widget.choreName,
                assignedTo: widget.assignedTo,
                isCompleted: isCompleted,
              ),
            ),
          );
        },
      ),
    );
  }
}

