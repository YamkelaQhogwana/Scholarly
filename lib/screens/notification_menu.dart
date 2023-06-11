import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
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
              SizedBox(height: 16),
              Text(
                'Turn on/off the following notifications and reminders',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Text(
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
                contentPadding: EdgeInsets.all(0),
                title: Text(
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
                      title: Text('Off'),
                      value: 0,
                      groupValue: dailyHabitReminderValue,
                      onChanged: (value) {
                        setState(() {
                          dailyHabitReminderValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
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
                contentPadding: EdgeInsets.all(0),
                title: Text(
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
                      title: Text('Off'),
                      value: 0,
                      groupValue: taskNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          taskNotificationsValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
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
                contentPadding: EdgeInsets.all(0),
                title: Text(
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
                      title: Text('Off'),
                      value: 0,
                      groupValue: streakNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          streakNotificationsValue = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
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
        child: Icon(Icons.add),
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
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.school),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassesPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.newspaper),
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
      ),
    );
  }
}
