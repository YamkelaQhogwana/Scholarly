import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/habits.dart';

class AddHabits extends StatelessWidget {
  const AddHabits({Key? key}) : super(key: key);

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
                                  builder: (context) => const HabitsPage(),
                                ),
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
                        const SizedBox(width: 8.0),
                        const Padding(
                          padding: EdgeInsets.only(top: 120),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Add your desired habits and goals:',
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

            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kBrownLight,
                        text: 'Call Parents',
                        imagePath: 'assets/images/habiticons/parents.png',subText: 'Everyday',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kBrownDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kBrownDark,),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kGreenLight,
                        text: 'Revision',
                        imagePath: 'assets/images/habiticons/revision.png', subText: 'Everyday',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kGreenDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kGreenDark,),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kBlueLight,
                        text: 'Drink Water',
                        imagePath: 'assets/images/habiticons/water.png', subText: 'Everyday',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kBlueDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kBlueDark,),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kOrangeLight,
                        text: 'Go for Walk',
                        imagePath: 'assets/images/habiticons/walk.png', subText: 'Everyday',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kOrangeDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kOrangeDark,),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kPinkLight,
                        text: 'Daily Journal',
                        imagePath: 'assets/images/habiticons/journal.png', subText: 'Everyday',
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kPinkDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kPinkDark,),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxWidget(
                        color: AppColors.kPurpleLight,
                        text: 'Sleep Early',
                        imagePath: 'assets/images/habiticons/sleep.png',subText: 'Everyday',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxWidget(label: 'M', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'W', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'T', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'F', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kPurpleDark,),
                      CheckboxWidget(label: 'S', color: AppColors.kPurpleDark,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Placeholder code for save button
                        print('Save Habits and Goals pressed');
                      }, style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(300, 45)), // Adjust the size as per your requirement
                    ),
                      child: const Text('Save Habits and Goals'),
                    ),
                  ),
                ],
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
              padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding as needed
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subText,
                      style: const TextStyle(
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