import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/modules/stats.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/info.dart';

class MenuStatistics extends StatelessWidget {
  const MenuStatistics({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kMainText, size: 18),
        title: const Text('Statistics',
            style: TextStyle(color: AppColors.kMainText, fontSize: 16)),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Overview',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBlock(
                  'Completed Tasks',
                  '${DummyStatsData.totalTasksCompleted}',
                ),
                const SizedBox(height: 16.0),
                _buildStatBlock(
                  'Total Habits',
                  '${DummyStatsData.currentHabitsTracked}',
                ),
                const SizedBox(height: 16.0),
                _buildStatBlock(
                  'Highest Habit Streak',
                  '${DummyStatsData.highestHabitStreak}',
                ),
                const SizedBox(height: 24.0),
              ],
            ),
            const SizedBox(height: 25.0),
            // BarGraphWidget(DummyStatsData.tasksCompletedWeek),
            const SizedBox(height: 10.0),
            // BarGraphWidget(DummyStatsData.habitsCompletedWeek),
            const SizedBox(height: 25.0),
            const Text('Habit Streaks',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 1,
              children: [
                for (HabitTracker habitTracker in DummyStatsData.habitTrackers)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildStatBlock(
                      habitTracker.name,
                      habitTracker.streak.toString(),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: kBottomNavigationBarHeight / 2,
            left: (MediaQuery.of(context).size.width - 56) / 2,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.kPrimary400,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                onPressed: () {
                  // Placeholder code for add button
                  print('Add button pressed');
                },
                icon: const Icon(Icons.add, color: Colors.white),
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
              color: AppColors.kPrimary400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
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
                  MaterialPageRoute(builder: (context) => InformationCentre()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBlock(String label, String value) {
    return Container(
      width: 110,
      height: 110,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.kBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimary400),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 12.0,
                color: AppColors.kMainText,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
