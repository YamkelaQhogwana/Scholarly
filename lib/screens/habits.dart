import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/edithabits.dart';
import 'main_screen_menu.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
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
                                    builder: (context) => MenuPage()),
                              );
                            },
                            child: SizedBox(
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
                        const SizedBox(width: 8.0),
                        const Padding(
                          padding: EdgeInsets.only(top: 43),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 110, left: 60),
                          child: SizedBox(
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
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AddHabits()),
                                      );
                                    },
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color(
                                            0xFF8D8F9D), // Set the desired color here
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
                      padding: EdgeInsets.only(
                          right: 232.0, top: 10), // Set the desired padding
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
        backgroundColor: AppColors.kPrimary400,
        child: const Icon(Icons.add),
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
