import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/edithabits.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HabitWidget extends StatelessWidget {
  final Habit habit;
  static List<Color> colorPalette = [
    AppColors.kBlueLight,
    AppColors.kGreenLight,
    AppColors.kRedLight,
  ];
  static List<String> imagePathList = [
    'images/habiticons/journal.png',
    'images/habiticons/water.png',
    'images/habiticons/walk.png',
    'images/habiticons/revision.png',
    'images/habiticons/sleep.png',
    'images/habiticons/parents.png',
  ];
  static List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  const HabitWidget({Key? key, required this.habit}) : super(key: key);

  Color getRandomColor() {
    final random = Random();
    return colorPalette[random.nextInt(colorPalette.length)];
  }

  String getRandomImagePath() {
    final random = Random();
    return imagePathList[random.nextInt(imagePathList.length)];
  }

  List<bool> getInitialCheckboxValues() {
    final List<bool> initialCheckboxValues =
        List.filled(daysOfWeek.length, false);
    for (int i = 0; i < habit.days; i++) {
      initialCheckboxValues[i] = true;
    }
    return initialCheckboxValues;
  }

  @override
  Widget build(BuildContext context) {
    final boxColor = getRandomColor();
    final imagePath = getRandomImagePath();
    final initialCheckboxValues = getInitialCheckboxValues();

    return Column(
      children: [
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxWidget(
              color: boxColor,
              text: habit.name,
              imagePath: imagePath,
              subText: '${habit.days} days per week',
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < daysOfWeek.length; i++)
              CheckboxWidget(
                label: daysOfWeek[i],
                color: AppColors.kBlueDark,
                initialValue: initialCheckboxValues[i],
              ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                showEditPopup(context, habit.name);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                showDeleteConfirmation(context, habit.name);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showEditPopup(BuildContext context, String habitName) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Habit'),
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter new number of days',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedDays = int.tryParse(textController.text);
                if (updatedDays != null &&
                    updatedDays >= 1 &&
                    updatedDays <= 7) {
                  updateHabitDays(habitName, updatedDays);
                  Navigator.pop(context);
                } else {
                  // Invalid input
                  print('Invalid input');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmation(BuildContext context, String habitName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Habit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteHabit(habitName);
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void updateHabitDays(String habitName, int newDays) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userEmail = user.email;
      final habitsRef = FirebaseFirestore.instance.collection('habits');
      final habitDoc = await habitsRef
          .where('userEmail', isEqualTo: userEmail)
          .where('name', isEqualTo: habitName)
          .get();
      if (habitDoc.size > 0) {
        final docId = habitDoc.docs.first.id;
        await habitsRef.doc(docId).update({'days': newDays});
        // Success! Handle any additional logic here
      } else {
        // Habit not found
        print('Habit not found');
      }
    }
  }

  void deleteHabit(String habitName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userEmail = user.email;
      final habitsRef = FirebaseFirestore.instance.collection('habits');
      final habitDoc = await habitsRef
          .where('userEmail', isEqualTo: userEmail)
          .where('name', isEqualTo: habitName)
          .get();
      if (habitDoc.size > 0) {
        final docId = habitDoc.docs.first.id;
        await habitsRef.doc(docId).delete();
        // Success! Handle any additional logic here
      } else {
        // Habit not found
        print('Habit not found');
      }
    }
  }
}

class CheckboxWidget extends StatefulWidget {
  final String label;
  final Color color;
  final bool initialValue;

  const CheckboxWidget({
    required this.label,
    required this.color,
    required this.initialValue,
  });

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isChecked ? widget.color : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: widget.color),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: isChecked ? Colors.white : widget.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final Color color;
  final String text;
  final String imagePath;
  final String subText;

  const BoxWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.imagePath,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 120.0,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imagePath,
            width: 48.0,
            height: 48.0,
          ),
          Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
