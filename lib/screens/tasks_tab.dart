import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: 5, // Number of tasks
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.task),
              title: Text('Task $index'),
              subtitle: Text('Description of Task $index'),
              trailing: Checkbox(
                value: false,
                onChanged: (value) {
                  // Handle checkbox onChanged event
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
