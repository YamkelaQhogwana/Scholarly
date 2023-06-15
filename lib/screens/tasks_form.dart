import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scholarly/screens/tasks_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Form Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Bottom Sheet'),
          onPressed: () {
            showTaskFormBottomSheet(context);
          },
        ),
      ),
    );
  }
}

void showTaskFormBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        widthFactor: 1,
        child: DraggableScrollableSheet(
          initialChildSize: 0.86, // Adjust this value to fit the screen
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: TaskFormPageContent(),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class TaskFormPageContent extends StatefulWidget {
  @override
  _TaskFormPageContentState createState() => _TaskFormPageContentState();
}

class _TaskFormPageContentState extends State<TaskFormPageContent> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = [
    'School',
    'Work',
    'Personal',
    'Misc',
    'Class'
  ];
  String _selectedCategory = 'School';
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  TextEditingController _participantsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _participantsController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showStartTimePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );

    if (selectedTime != null && selectedTime != _startTime) {
      setState(() {
        _startTime = selectedTime;
      });
    }
  }

  Future<void> _showEndTimePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );

    if (selectedTime != null && selectedTime != _endTime) {
      setState(() {
        _endTime = selectedTime;
      });
    }
  }

  void _createTask() async {
    if (_formKey.currentState!.validate()) {
      // Perform task creation logic
      // You can access the form field values using the respective controller values
      String title = _descriptionController.text;
      String category = _selectedCategory;
      TimeOfDay _startTime = TimeOfDay.now();
      TimeOfDay _endTime = TimeOfDay.now();
      String participants = _participantsController.text;
      String location = _locationController.text;
      String description = _descriptionController.text;

      // Save the form data to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('title', title);
      prefs.setString('category', category);
      prefs.setString('startTime', _startTime.toString());
      prefs.setString('endTime', _endTime.toString());
      prefs.setString('participants', participants);
      prefs.setString('location', location);
      prefs.setString('description', description);

      // Reset the form fields
      _formKey.currentState!.reset();
      _selectedCategory = 'School';
      _startTime = TimeOfDay.now();
      _endTime = TimeOfDay.now();
      _participantsController.clear();
      _locationController.clear();
      _descriptionController.clear();

      // Navigate to TasksPage and pass form data
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('OK'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: TextStyle(
                color: Colors.black, // Change the text color here
              ),
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Category'),
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items:
                  _categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Start'),
                    subtitle: Text(_startTime.toString().substring(0, 10)),
                    onTap: _showStartTimePicker,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('End'),
                    subtitle: Text(_endTime.toString().substring(0, 10)),
                    onTap: _showEndTimePicker,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _participantsController,
              decoration: InputDecoration(labelText: 'Participants'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createTask,
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
