import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: const Text("Information Center Page"),
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
              icon: const Icon(Icons.add, color: Colors.white), // Set the icon color
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
            icon: const Icon(Icons.home),
            color: AppColors.kMainText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            color: AppColors.kMainText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );
            },
          ),
          const SizedBox(width: 56), // Empty space for the float button
          IconButton(
            icon: const Icon(Icons.school),
            color: AppColors.kMainText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassesPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.newspaper),
            color: AppColors.kPrimary400,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoPage()),
              );
            },
          ),
        ],
      ),
    )
    );
  }
}
