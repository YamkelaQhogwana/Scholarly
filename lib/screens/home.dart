import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/constants/custom_appbar_main.dart';
import 'package:scholarly/screens/add_task.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:scholarly/screens/menu/habits.dart';
import 'package:scholarly/screens/menu/notification_menu.dart';
import 'package:scholarly/screens/menu/profile_menu.dart';
import 'package:scholarly/screens/menu/statistics.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarMain(),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: const Text("Home/Main Page"),
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
                  // showTaskFormBottomSheet(context);
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             SizedBox(
              height: 250.0,
               child: DrawerHeader(
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/avatars/black-wn-av.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Jane Doe',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Third Year',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                         ),
             ),
            ListTile(
              leading: const Iconify(MaterialSymbols.person_2_rounded),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileMenu(),
                  ),
                );
                // Add your logic for Inbox onTap
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.bell_badge),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsMenu(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.clock_check),
              title: const Text('Habits/Goals'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HabitsPage(),
                  ),
                );
                // Add your logic for Sent onTap
              },
            ),
            ListTile(
              leading: const Iconify(Gridicons.stats_down_alt),
              title: const Text('Statistics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuStatistics(),
                  ),
                );
                // Add your logic for Sent onTap
              },
            ),
            ListTile(
              leading: const Iconify(Mdi.comment_text),
              title: const Text('Feedback'),
              onTap: () {
                print('Feedback');
              },
            ),
            ListTile(
              leading: const Iconify(Majesticons.logout),
              title: const Text('Logout'),
              onTap: () {
                print('Logout Clicked');
              },
            ),
            ListTile(
              leading: const Iconify(Bx.bxs_moon),
              title: const Text('Dark Mode'),
              onTap: () {
                print('DarkMode');
              },
            ),
            const SizedBox(
              height: 50,
            ),
             const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: Text(
                    'Scholarly v.1.0.0',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
              ),
             ),
          ],
        ),
        
      ),
    );
  }
}

