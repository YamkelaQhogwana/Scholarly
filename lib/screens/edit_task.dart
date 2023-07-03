import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarly/constants/colors.dart';

class EditTaskPage extends StatefulWidget {
  final DocumentSnapshot task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _participantsController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _participantsController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();

    Future.delayed(Duration(milliseconds: 100), () {
      loadTaskDetails();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _participantsController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  void loadTaskDetails() async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('tasks').doc(widget.task.id).get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        _titleController.text = data['title'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _locationController.text = data['location'] ?? '';
        _participantsController.text = data['participants'] ?? '';
        _startTimeController.text = data['startTime'] ?? '';
        _endTimeController.text = data['endTime'] ?? '';
      }
    } catch (e) {
      print('Error loading task details: $e');
    }
  }

  void updateTaskDetails() async {
    try {
      await firestore.collection('tasks').doc(widget.task.id).update({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'participants': _participantsController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task updated successfully')),
      );

      // You can also navigate back to the previous page if needed
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task')),
      );
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kMainText, size: 18),
        title: const Text('Edit Task',
            style: TextStyle(color: AppColors.kMainText, fontSize: 16)),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _participantsController,
              decoration: InputDecoration(labelText: 'Participants'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Start Time'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'End Time'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateTaskDetails,
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
