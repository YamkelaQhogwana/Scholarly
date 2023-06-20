import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/edithabits.dart';
import 'dart:math';

class HabitWidget extends StatelessWidget {
  final Habit habit;
  static List<Color> colorPalette = [
    AppColors.kBlueLight,
    AppColors.kGreenLight,
    AppColors.kRedLight,
  ];

  const HabitWidget({Key? key, required this.habit}) : super(key: key);

  Color getRandomColor() {
    final random = Random();
    return colorPalette[random.nextInt(colorPalette.length)];
  }

  @override
  Widget build(BuildContext context) {
    final boxColor = getRandomColor();
    return Column(
      children: [
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxWidget(
              color: boxColor,
              text: habit.name,
              imagePath: 'assets/images/habiticons/water.png',
              subText: '${habit.days} days per week',
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckboxWidget(
              label: 'M',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'T',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'W',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'T',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'F',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'S',
              color: AppColors.kBlueDark,
            ),
            CheckboxWidget(
              label: 'S',
              color: AppColors.kBlueDark,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Implement your update habit logic here
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                // Implement your delete habit logic here
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
}
