import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarly/constants/colors.dart';

class TasksPage extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final DateTime selectedDay; // Added selectedDay parameter

  TasksPage({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('userId', isEqualTo: currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Color> colors = [
            Color.fromRGBO(236, 216, 199, 1), // Go for a walk
            Color.fromRGBO(218, 240, 209, 1), // Revision
            Color.fromRGBO(208, 224, 247, 1), // Drink water
            Color.fromRGBO(255, 234, 209, 1), // Go for a walk
            AppColors.kBrown,
          ];
          List<Color> shuffledColors = List.of(colors)..shuffle();
          Map<String, List<Widget>> tasksByTime = {};
          // Iterate over the task documents
          snapshot.data!.docs.forEach((taskDoc) {
            var taskData = taskDoc.data() as Map<String, dynamic>;
            DateTime taskDate = (taskData['date'] as Timestamp).toDate();
            if (isSameDay(selectedDay, taskDate)) {
              var startTime = taskData['startTime'] as String;
              tasksByTime.putIfAbsent(startTime, () => []);
              tasksByTime[startTime]!.add(buildTaskWidget(
                  taskDoc,
                  taskData,
                  shuffledColors[
                      tasksByTime[startTime]!.length % shuffledColors.length]));
            }
          });

          if (tasksByTime.isEmpty) {
            // Display "No tasks available" if there are no tasks for the selected day
            return Center(
              child: Text(
                'No tasks available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasksByTime.length,
            itemBuilder: (context, index) {
              var startTime = tasksByTime.keys.elementAt(index);
              var taskWidgets =
                  tasksByTime[startTime] ?? []; // Handle nullability

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      startTime,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(children: taskWidgets),
                ],
              );
            },
          );
        },
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget buildTaskWidget(DocumentSnapshot taskDoc,
      Map<String, dynamic> taskData, Color cardColor) {
    String title = taskData['title'];
    String description = taskData['description'];
    String startTime = taskData['startTime'];
    String endTime = taskData['endTime'];
    bool isTaskDone = taskData['done'] ?? false;

    return Card(
      color: cardColor, // Assign the unique color to the card
      child: ListTile(
        title: Text(
          '$title - $description',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$startTime - $endTime',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: CustomPaint(
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            value: isTaskDone,
            onChanged: (value) {
              // Update the 'done' field of the task in Firestore
              taskDoc.reference.update({'done': value});
            },
          ),
        ),
      ),
    );
  }
}
