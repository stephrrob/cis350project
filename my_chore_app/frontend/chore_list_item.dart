import 'package:flutter/material.dart';

class ChoreListItem extends StatefulWidget {
  final String choreName;
  final String assignedTo;

  const ChoreListItem({
    required this.choreName,
    required this.assignedTo,
    Key? key,
  }) : super(key: key);

  @override
  ChoreListItemState createState() => ChoreListItemState();
}

class ChoreListItemState extends State<ChoreListItem> {
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

class ChoreDetailsScreen extends StatelessWidget {
  final String choreName;
  final String assignedTo;
  final bool isCompleted;

  const ChoreDetailsScreen({
    required this.choreName,
    required this.assignedTo,
    required this.isCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choreName),
      ),
      body: Column(
        children: <Widget>[
          Text('Chore Name: $choreName'),
          Text('Assigned To: $assignedTo'),
          Text('Is Completed: $isCompleted'),
        ],
      ),
    );
  }
}
