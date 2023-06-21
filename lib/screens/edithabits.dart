import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/habits.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/habit_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholarly/screens/main_screen_menu.dart';

class AddHabits extends StatefulWidget {
  const AddHabits({Key? key}) : super(key: key);

  @override
  _AddHabitsState createState() => _AddHabitsState();
}

class _AddHabitsState extends State<AddHabits> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController numberOfDaysController = TextEditingController();

  // Add a variable to store the fetched habits
  List<Habit> habits = [];

  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: habitNameController,
                decoration: InputDecoration(labelText: 'Habit Name'),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: numberOfDaysController,
                decoration: InputDecoration(labelText: 'Number of Days'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the entered values from the controllers
                final String habitName = habitNameController.text.trim();
                final String numberOfDaysText =
                    numberOfDaysController.text.trim();
                final int numberOfDays = int.tryParse(numberOfDaysText) ?? 0;
                final user = FirebaseAuth.instance.currentUser;
                final userEmail = user?.email ?? '';

                // Check if habit name and days are valid
                if (habitName.isEmpty ||
                    numberOfDaysText.isEmpty ||
                    numberOfDays > 7) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Data'),
                        content: Text(
                            'Please enter valid habit name and number of days (less than or equal to 7).'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return; // Do not proceed with adding the habit to the database
                }

                // Create a new habit with the entered data
                final Habit newHabit = Habit(
                  userEmail: userEmail,
                  name: habitName,
                  days: numberOfDays,
                  isCompleted: false,
                );

                // Insert the new habit into the database
                // Insert the new habit into the database
                FirebaseFirestore.instance
                    .collection('habits')
                    .add(newHabit.toMap())
                    .then((value) {
                  // Update the fetched habits list with the new habit
                  setState(() {
                    habits.add(newHabit);
                  });

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Show a snackbar to indicate the new habit creation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New habit created')),
                  );
                });
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Fetch habits for the logged-in user
  void fetchHabits() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? '';
    final querySnapshot = await FirebaseFirestore.instance
        .collection('habits')
        .where('userEmail', isEqualTo: userEmail)
        .get();

    final List<Habit> fetchedHabits = querySnapshot.docs
        .map((doc) => Habit.fromMap(doc.data() as Map<String, dynamic>))
        .toList() as List<Habit>;

    setState(() {
      habits = fetchedHabits;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHabits(); // Fetch habits when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: double.infinity,
                height: 200.0,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: 47,
                          left: 21,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitsPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              child: SvgPicture.string(
                                '''
                                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                    <g fill="none" fill-rule="evenodd">
                                      <path d="M24 0v24H0V0h24ZM12.593 23.258l-.011.002l-.071.035l-.02.004l-.014-.004l-.071-.035c-.01-.004-.019-.001-.024.005l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427c-.002-.01-.009-.017-.017-.018Zm.265-.113l-.013.002l-.185.093l-.01.01l-.003.011l.018.43l.005.012l.008.007l.201.093c.012.004.023 0 .029-.008l.004-.014l-.034-.614c-.003-.012-.01-.02-.02-.022Zm-.715.002a.023.023 0 0 0-.027.006l-.006.014l-.034.614c0 .012.007.02.017.024l.015-.002l.201-.093l.01-.008l.004-.011l.017-.43l-.003-.012l-.01-.01l-.184-.092Z"/>
                                      <path fill="currentColor" d="M8.293 12.707a1 1 0 0 1 0-1.414l5.657-5.657a1 1 0 1 1 1.414 1.414L10.414 12l4.95 4.95a1 1 0 0 1-1.414 1.414l-5.657-5.657Z"/>
                                    </g>
                                  </svg>
                                ''',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Habits and Goals',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Padding(
                          padding: EdgeInsets.only(top: 120),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'View, Edit and Update Your Habits',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: _showAddHabitDialog, // Show the add habit dialog
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30.0,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Add Habit',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children:
                    habits.map((habit) => HabitWidget(habit: habit)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(300, 45)), // Adjust the size as per your requirement
                ),
                child: Text('Save Habits and Goals'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder code for add button
          print('Add button pressed');
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.kPrimary400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: AppColors.kPrimary400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            SizedBox(width: 56),
            IconButton(
              icon: Icon(Icons.school),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassesPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.newspaper),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationCentre()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final Color color;
  final String text;
  final String subText;
  final String imagePath;

  const BoxWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.subText,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: 150.0,
        height: 150.0,
        color: color,
        child: Stack(
          children: [
            Positioned(
              top: 35.0,
              left: 63.0,
              child: Image.asset(
                imagePath,
                width: 24.0,
                height: 24.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0), // Adjust the top padding as needed
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subText,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  final String userEmail;
  final String name;
  final int days;
  final bool isCompleted;

  Habit({
    required this.userEmail,
    required this.name,
    required this.days,
    required this.isCompleted,
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      userEmail: map['userEmail'],
      name: map['name'],
      days: map['days'],
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'name': name,
      'days': days,
      'isCompleted': isCompleted,
    };
  }
}

@override
_CheckboxWidgetState createState() => _CheckboxWidgetState();

class CheckboxWidget extends StatefulWidget {
  final String label;
  final Color color;

  const CheckboxWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
          color: isChecked ? widget.color : Colors.transparent,
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              color: isChecked ? Colors.white : Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
