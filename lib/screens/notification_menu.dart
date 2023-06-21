import 'package:flutter/material.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsMenu extends StatefulWidget {
  const NotificationsMenu({Key? key}) : super(key: key);

  @override
  _NotificationsMenuState createState() => _NotificationsMenuState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _NotificationsMenuState extends State<NotificationsMenu> {
  bool pauseAll = true;
  int habitNotificationsValue = 0;
  int taskNotificationsValue = 0;
  int streakNotificationsValue = 0;

  @override
  void initState() {
    super.initState();
    fetchNotificationSettings();
    initializeNotifications();
  }

  Future<void> fetchNotificationSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? '';

    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs[0].data();

        setState(() {
          pauseAll = userData['pauseNotifications'] ?? false;
          habitNotificationsValue = userData['habitNotifications'] ?? 0;
          taskNotificationsValue = userData['taskNotifications'] ?? 0;
          streakNotificationsValue = userData['streakNotifications'] ?? 0;
        });
      }
    }
  }

  Future<void> updateNotificationSettings() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? '';

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        String documentId = doc.id;

        Map<String, dynamic> updatedData = {
          'pauseNotifications': pauseAll,
          'habitNotifications': habitNotificationsValue,
          'taskNotifications': taskNotificationsValue,
          'streakNotifications': streakNotificationsValue,
        };

        if (pauseAll) {
          updatedData['habitNotifications'] = 0;
          updatedData['taskNotifications'] = 0;
          updatedData['streakNotifications'] = 0;

          setState(() {
            habitNotificationsValue = 0;
            taskNotificationsValue = 0;
            streakNotificationsValue = 0;
          });
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .update(updatedData);
      }
    }
  }

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification',
    );
  }

  void handleNotificationSelection(String? payload) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (Route<dynamic> route) => false,
    );
  }

  void showHabitNotification() {
    sendNotification(
        'Habit Notification', 'Remember to perform your daily habit!');
  }

  void showTaskNotification() {
    sendNotification(
        'Task Notification', 'You have a pending task to complete!');
  }

  void showStreakNotification() {
    sendNotification(
        'Streak Notification', 'Keep up the good work! Your streak continues!');
  }

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
                      updateNotificationSettings();
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
                      groupValue: habitNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          habitNotificationsValue = value as int;
                          updateNotificationSettings();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('On'),
                      value: 1,
                      groupValue: habitNotificationsValue,
                      onChanged: (value) {
                        setState(() {
                          habitNotificationsValue = value as int;
                          updateNotificationSettings();
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
                          updateNotificationSettings();
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
                          updateNotificationSettings();

                          if (value == 1) {
                            showTaskNotification();
                          }
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
                          updateNotificationSettings();
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
                          updateNotificationSettings();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()),
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
                    MaterialPageRoute(builder: (context) => InformationCentre()),
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
