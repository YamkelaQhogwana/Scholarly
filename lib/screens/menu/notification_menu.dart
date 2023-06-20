import 'package:flutter/material.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';

class NotificationsMenu extends StatefulWidget {
  const NotificationsMenu({Key? key}) : super(key: key);

  @override
  _NotificationsMenuState createState() => _NotificationsMenuState();
}

class _NotificationsMenuState extends State<NotificationsMenu> {
  bool pauseAll = true; // Variable to track the state of the toggle switch

  int dailyHabitReminderValue =
      0; // Variable to track the selected radio button
  int taskNotificationsValue = 0; // Variable to track the selected radio button
  int streakNotificationsValue =
      0; // Variable to track the selected radio button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Notifications',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Turn on/off the following notifications and reminders',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const Text(
                  'Pause All',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  value: pauseAll,
                  onChanged: (bool value) {
                    setState(() {
                      pauseAll = value;
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Daily Habit Reminder',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    RadioListTile(
                      title: const Text('Off'),
                      value: 0,
                      groupValue: dailyHabitReminderValue,
                      onChanged: (value) {
                        setState(() {
                          dailyHabitReminderValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('On'),
                      value: 1,
                      groupValue: dailyHabitReminderValue,
                      onChanged: (value) {
                        setState(() {
                          dailyHabitReminderValue = value as int;
                        });
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Task Notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    RadioListTile(
                      title: const Text('Off'),
                      value: 0,
                      groupValue: taskNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          taskNotificationsValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('On'),
                      value: 1,
                      groupValue: taskNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          taskNotificationsValue = value as int;
                        });
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Streak Notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    RadioListTile(
                      title: const Text('Off'),
                      value: 0,
                      groupValue: streakNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          streakNotificationsValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('On'),
                      value: 1,
                      groupValue: streakNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          streakNotificationsValue = value as int;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating button pressed');
        },
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalendarPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.school),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassesPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.newspaper),
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
      ),
    );
  }
}
