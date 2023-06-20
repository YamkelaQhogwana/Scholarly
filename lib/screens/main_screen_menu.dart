import 'package:flutter/material.dart';
import 'dart:ui';
import 'habits.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'profile_menu.dart';
import 'notification_menu.dart';
import 'edithabits.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholarly/screens/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Poppins'),
        child: Stack(
          children: [
            Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: Center(
                child: Text(
                  'Main Content',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 64.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/avatars/black-wn-av.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Jane Doe',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Third Year',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Expanded(
                      child: Column(
                        children: [
                          MenuItem(
                            iconData: Icons.person,
                            title: 'Profile',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileMenu(),
                                ),
                              );
                            },
                          ),
                          MenuItem(
                            iconData: Icons.notifications,
                            title: 'Notifications',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationsMenu(),
                                ),
                              );
                            },
                          ),
                          MenuItem(
                            iconData: Icons.check_box,
                            title: 'Habits/Goals',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddHabits()),
                              );
                            },
                          ),
                          MenuItem(
                            iconData: Icons.insert_chart,
                            title: 'Statistics',
                            onTap: () {
                              // Handle Statistics menu item click
                              print('Statistics Clicked');
                              // Perform navigation or any other actions
                            },
                          ),
                          MenuItem(
                            iconData: Icons.feedback,
                            title: 'Feedback',
                            onTap: () {
                              // Handle Feedback menu item click
                              print('Feedback Clicked');
                              // Perform navigation or any other actions
                            },
                          ),
                          MenuItem(
                            iconData: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              // Handle Logout menu item click
                              print('Logout Clicked');
                              // Perform navigation or any other actions
                            },
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Icon(Icons.dark_mode),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Dark Mode',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(width: 8.0),
                              Switch(
                                value: isDarkMode,
                                onChanged: (bool value) {
                                  setState(() {
                                    isDarkMode = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Scholarly v.1.0.0',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
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

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback? onTap;

  const MenuItem({
    required this.iconData,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 24.0,
            ),
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
