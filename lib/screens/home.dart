// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Text("Main Screen/Home Page"),
      ),
      floatingActionButton: Stack(
      children: [
        Positioned(
          bottom: kBottomNavigationBarHeight / 2,
          left: (MediaQuery.of(context).size.width - 56) / 2, // Adjust the left position
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.kPrimary400, // Set your desired button color here
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IconButton(
              onPressed: () {
                // Placeholder code for add button
                print('Add button pressed');
              },
              icon: Icon(Icons.add, color: Colors.white), // Set the icon color
            ),
          ),
        ),
      ],
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
      SizedBox(width: 56), // Empty space for the float button
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
            MaterialPageRoute(builder: (context) => InfoPage()),
          );
        },
      ),
    ],
  ),
),
);
  
}
}