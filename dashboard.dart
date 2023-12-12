import 'package:flutter/material.dart';
import 'chore_list_item.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chore Manager'),
      ),
      body: ListView(
        children: <Widget>[
          ChoreListItem(choreName: 'Clean the kitchen', assignedTo: 'John'),
          // Add more ChoreListItem widgets for other chores
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement navigation to chore creation screen
          Navigator.pushNamed(context, '/chore/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
