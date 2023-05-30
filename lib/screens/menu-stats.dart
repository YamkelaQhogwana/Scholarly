import 'package:flutter/material.dart';
import 'package:scholarly/modules/stats.dart';

class MenuStatistics extends StatelessWidget {
  const MenuStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Number of Tasks Completed: ${DummyStatsData.totalTasksCompleted}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Current Number of Habits Being Tracked: ${DummyStatsData.currentHabitsTracked}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Highest Habit Streak: ${DummyStatsData.highestHabitStreak}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.0),
            Text(
              'Habits Completed This Week:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (int habitsCompleted in DummyStatsData.habitsCompletedWeek)
                  Expanded(
                    child: Text(
                      habitsCompleted.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24.0),
            Text(
              'Habits Completed This Month:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (int habitsCompleted in DummyStatsData.habitsCompletedMonth)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      habitsCompleted.toString(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24.0),
            Text(
              'Tasks Completed This Week:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (int tasksCompleted in DummyStatsData.tasksCompletedWeek)
                  Expanded(
                    child: Text(
                      tasksCompleted.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24.0),
            Text(
              'Tasks Completed This Month:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (int tasksCompleted in DummyStatsData.tasksCompletedMonth)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      tasksCompleted.toString(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
