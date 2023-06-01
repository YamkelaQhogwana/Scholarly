import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart'; // Import InfoPage class

void main() {
  runApp(EditProfileApp());
}

class EditProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatelessWidget {
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
                        // Placeholder code for the back button
                        print('Back button pressed');
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
                  value: true, // Replace with your toggle value
                  onChanged: (bool value) {
                    // Placeholder code for toggle onChanged
                    print('Pause All toggle changed: $value');
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Daily Habbit Reminder',
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
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Daily Habbit Reminder radio changed: $value');
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
                      value: 1,
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Daily Habbit Reminder radio changed: $value');
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
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Task Notifications radio changed: $value');
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
                      value: 1,
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Task Notifications radio changed: $value');
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
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Streak Notifications radio changed: $value');
                      },
                    ),
                    RadioListTile(
                      title: Text('On'),
                      value: 1,
                      groupValue: 0, // Replace with your group value
                      onChanged: (value) {
                        // Placeholder code for radio onChanged
                        print('Streak Notifications radio changed: $value');
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
          // Placeholder code for the floating button
          print('Floating button pressed');
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Adjust the border radius as desired
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
