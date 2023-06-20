import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/addhabits.dart';


class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kMainText, size: 18),
        title: const Text('Habits and Goals', style: TextStyle(color: AppColors.kMainText, fontSize: 16)),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248) ,
        elevation: 0,
      ),
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
                       Padding(
                          padding: const EdgeInsets.only(top: 110, left: 60),
                          child: Container(
                            width: 50.0, // Adjust the width as needed
                            height: 50.0, // Adjust the height as needed
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/habitspage/addhabit.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const AddHabits()),
                                      );
                                    },
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFF8D8F9D), // Set the desired color here
                                        BlendMode.srcIn,
                                      ),
                                      child: SvgPicture.string(
                                        '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                          <path fill="currentColor" d="M19 12.998h-6v6h-2v-6H5v-2h6v-6h2v6h6z"/>
                                        </svg>''',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 232.0,top: 10), // Set the desired padding
                      child: Text(
                        'Add New Habit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
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
        child: const Icon(Icons.add),
        backgroundColor: AppColors.kPrimary400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: AppColors.kPrimary400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
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
            const SizedBox(width: 56),
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
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
