import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference get tasks => firestore.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Form',
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
        title: Text('Task Form'),
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
  int _selectedCategoryIndex = -1;

  final List<Color> _categoryColors = [
    AppColors.kBlueDark,
    AppColors.kGreenDark,
    AppColors.kRedDark,
    AppColors.kNavyDark,
    AppColors.kPurpleDark,
  ];

  String _selectedCategory = 'School';
  String _selectedStartTime = '08:00 AM';
  String _selectedEndTime = '09:00 AM';
  DateTime _selectedDate = DateTime.now(); // Added selected date
  TextEditingController _titleController = TextEditingController();
  TextEditingController _participantsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final List<String> _timeSlots = [
    '00:00 AM',
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '13:00 PM',
    '14:00 PM',
    '15:00 PM',
    '16:00 PM',
    '17:00 PM',
    '18:00 PM',
    '19:00 PM',
    '20:00 PM',
    '21:00 PM',
    '22:00 PM',
    '23:00 PM',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _participantsController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      // Access the form field values using the respective controller values
      String title = _titleController.text;
      String category = _selectedCategory;
      String participants = _participantsController.text;
      String location = _locationController.text;
      String description = _descriptionController.text;
      DateTime date = _selectedDate;

      // Create a map of the task data
      Map<String, dynamic> taskData = {
        'title': title,
        'category': category,
        'participants': participants,
        'location': location,
        'description': description,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'startTime': _selectedStartTime,
        'endTime': _selectedEndTime,
        'date': _selectedDate, // Added selected date
      };

      try {
        // Store the task data in Firestore
        FirebaseFirestore.instance.collection('tasks').add(taskData);

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task created successfully')),
        );

        // Reset the form fields
        _formKey.currentState!.reset();
        _titleController.clear();
        _selectedCategory = '';
        _participantsController.clear();
        _locationController.clear();
        _descriptionController.clear();
        _selectedStartTime = '';
        _selectedEndTime = '';
      } catch (error) {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create task')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
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
            Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                color: Color.fromARGB(
                    255, 49, 49, 49), // Change the text color here
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.asMap().entries.map((entry) {
                int index = entry.key;
                String category = entry.value;
                bool isSelected = index == _selectedCategoryIndex;

                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                      _selectedCategory = category;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _categoryColors[index % _categoryColors.length],
                    onPrimary:
                        isSelected ? Color.fromARGB(255, 43, 42, 42) : null,
                    textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.5,

                    color: Colors.black, // Change the text color here
                  ),
                ),
                TextButton(
                  onPressed: showDatePickerDialog,
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(_selectedDate),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.5,

                      color: Colors.black, // Change the text color here
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start Time',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.5,

                    color: Colors.black, // Change the text color here
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedStartTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStartTime = newValue!;
                    });
                  },
                  items: _timeSlots.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'End Time',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.5,

                    color: Colors.black, // Change the text color here
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedEndTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEndTime = newValue!;
                    });
                  },
                  items: _timeSlots.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _participantsController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                color:
                    Color.fromARGB(255, 0, 0, 0), // Change the text color here
                // Change the text color here
              ),
              decoration: const InputDecoration(
                labelText: 'Participants',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                color:
                    Color.fromARGB(255, 0, 0, 0), // Change the text color here
                // Change the text color here
              ),
              decoration: const InputDecoration(
                labelText: 'Location',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                color:
                    Color.fromARGB(255, 0, 0, 0), // Change the text color here
                // Change the text color here
              ),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: InputBorder.none,
              ),
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
