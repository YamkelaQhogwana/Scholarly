import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/constants/custom_appbar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/edit_task.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/menu/habits.dart';
import 'package:scholarly/screens/menu/notification_menu.dart';
import 'package:scholarly/screens/menu/profile_menu.dart';
import 'package:scholarly/screens/menu/statistics.dart';
import 'package:scholarly/screens/tasks_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  String icon = "";
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final DateTime _firstDay = DateTime(DateTime.now().year - 1);
  final DateTime _lastDay = DateTime(DateTime.now().year + 1);

  String _formatDate(DateTime date) {
    final month = DateFormat.MMMM().format(date);
    final day = DateFormat.d().format(date);
    final year = DateFormat.y().format(date);
    return '$month $day, $year';
  }

  String? loggedInUserId;
  List<DocumentSnapshot> tasks = [];
  DateTime _currentMonth = DateTime.now();

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchTasks();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Future<void> fetchUserData() async {
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
          icon = userData['icon'];
        });
      }
    }
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        loggedInUserId = user.uid;
      });
      await _fetchTasks();
    }
  }

  Future<void> _fetchTasks() async {
    final snapshot = await _firestore
        .collection('tasks')
        .where('userId', isEqualTo: loggedInUserId)
        .get();

    setState(() {
      tasks = snapshot.docs;
    });
  }

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'kYellowLight':
        return AppColors.kYellowLight;
      case 'kYellow':
        return AppColors.kYellow;
      case 'kYellowDark':
        return AppColors.kYellowDark;
      case 'kRedLight':
        return AppColors.kRedLight;
      case 'kRed':
        return AppColors.kRed;
      case 'kRedDark':
        return AppColors.kRedDark;
      case 'kBlueLight':
        return AppColors.kBlueLight;
      case 'kBlue':
        return AppColors.kBlue;
      case 'kBlueDark':
        return AppColors.kBlueDark;
      case 'kGreenLight':
        return AppColors.kGreenLight;
      case 'kGreen':
        return AppColors.kGreen;
      case 'kGreenDark':
        return AppColors.kGreenDark;
      case 'kPurpleLight':
        return AppColors.kPurpleLight;
      case 'kPurple':
        return AppColors.kPurple;
      case 'kPurpleDark':
        return AppColors.kPurpleDark;
      case 'kBrownLight':
        return AppColors.kBrownLight;
      case 'kBrown':
        return AppColors.kBrown;
      case 'kBrownDark':
        return AppColors.kBrownDark;
      case 'kPinkLight':
        return AppColors.kPinkLight;
      case 'kPink':
        return AppColors.kPink;
      case 'kPinkDark':
        return AppColors.kPinkDark;
      case 'kOrangeLight':
        return AppColors.kOrangeLight;
      case 'kOrange':
        return AppColors.kOrange;
      case 'kOrangeDark':
        return AppColors.kOrangeDark;
      case 'kBrightYellowLight':
        return AppColors.kBrightYellowLight;
      case 'kBrightYellow':
        return AppColors.kBrightYellow;
      case 'kBrightYellowDark':
        return AppColors.kBrightYellowDark;
      case 'kNavyLight':
        return AppColors.kNavyLight;
      case 'kNavy':
        return AppColors.kNavy;
      case 'kNavyDark':
        return AppColors.kNavyDark;
      default:
        return Colors.black;
    }
  }

  String _formatParticipants(String participants) {
    List<String> participantList = participants.split(',');

    if (participantList.length <= 1) {
      return participants;
    } else {
      return "${participantList[0]} +${participantList.length - 1}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(
                  color: AppColors.kMainText, fontWeight: FontWeight.w600),
              weekendTextStyle: const TextStyle(
                  color: AppColors.kDarkGray, fontWeight: FontWeight.w600),
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 224, 84),
                  borderRadius: BorderRadius.circular(5)),
              markerDecoration: const BoxDecoration(
                  color: AppColors.kPrimary400, shape: BoxShape.circle),
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              titleTextStyle: TextStyle(color: AppColors.kDarkGray),
              formatButtonVisible: false,
              leftChevronIcon:
                  Icon(Icons.chevron_left_rounded, color: AppColors.kMainText),
              rightChevronIcon:
                  Icon(Icons.chevron_right_rounded, color: AppColors.kMainText),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: AppColors.kMainText),
              weekendStyle: TextStyle(color: AppColors.kDarkGray),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 12,
              onPageChanged: (index) {
                setState(() {
                  _currentMonth = DateTime(_currentMonth.year, index + 1);
                });
              },
              itemBuilder: (context, index) {
                List<DocumentSnapshot> tasksForMonth = tasks
                    .where((task) =>
                        task['date'].toDate().month == _currentMonth.month)
                    .toList();

                Map<DateTime, List<DocumentSnapshot>> groupedTasks = {};

                for (DocumentSnapshot task in tasksForMonth) {
                  DateTime taskDate = task['date'].toDate();
                  DateTime dateOnly = DateTime(
                    taskDate.year,
                    taskDate.month,
                    taskDate.day,
                  );

                  if (groupedTasks.containsKey(dateOnly)) {
                    groupedTasks[dateOnly]!.add(task);
                  } else {
                    groupedTasks[dateOnly] = [task];
                  }
                }

                List<DateTime> sortedDates = groupedTasks.keys.toList()
                  ..sort((a, b) => a.compareTo(b));

                return ListView.builder(
                  itemCount: sortedDates.length,
                  itemBuilder: (context, index) {
                    DateTime date = sortedDates[index];
                    List<DocumentSnapshot> tasksForDay = groupedTasks[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                DateFormat('EEEE, MMMM d').format(date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.kDarkGray,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Divider(
                                  color: AppColors.kDarkGray,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tasksForDay.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot task = tasksForDay[index];

                            final startTime = task['startTime'] as String;
                            final endTime = task['endTime'] as String;

                            return ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditTaskPage(
                                                                task: task),
                                                      ),
                                                    );
                                                  },
                                                  child: const IconButton(
                                                    icon: Iconify(
                                                      MaterialSymbols
                                                          .edit_square_outline_rounded,
                                                      size: 20,
                                                      color:
                                                          AppColors.kDarkGray,
                                                    ),
                                                    onPressed: null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              'Task Title',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: AppColors.kDarkGray),
                                            ),
                                            Text(
                                              task['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'insert duration later',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: AppColors.kDarkGray),
                                            ),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: AppColors.kDarkGray),
                                            ),
                                            Text(
                                              task['description'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.kDarkGray),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Venue',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .kDarkGray),
                                                    ),
                                                    Text(
                                                      task['location']
                                                              .isNotEmpty
                                                          ? task['location']
                                                          : 'Unknown',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 25),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Participants',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .kDarkGray),
                                                    ),
                                                    Text(
                                                      task['participants']
                                                              .isNotEmpty
                                                          ? task['participants']
                                                          : 'None',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  bool isDone = task['done'];
                                                  task.reference.update(
                                                      {'done': !isDone});
                                                });
                                              },
                                              child:
                                                  const Text('Task Complete'),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                            (states) {
                                                  bool isDone = task['done'];
                                                  return isDone
                                                      ? Colors.grey
                                                      : AppColors.kPrimary400;
                                                }),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all<
                                                        Size>(
                                                  const Size(
                                                      double.infinity, 0),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.kDarkGray),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('HH:mm').format(
                                      DateFormat('hh:mm a').parse(startTime),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(
                                      DateFormat('hh:mm a').parse(endTime),
                                    ),
                                  ),
                                ],
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.kPrimary400,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          task['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Iconify(Octicon.location,
                                            size: 15,
                                            color: AppColors.kDarkGray),
                                        const SizedBox(width: 4),
                                        Text(task['location'].isNotEmpty
                                            ? task['location']
                                            : 'Unknown'),
                                        const SizedBox(width: 10),
                                        const Iconify(Bi.person,
                                            size: 20,
                                            color: AppColors.kDarkGray),
                                        const SizedBox(width: 4),
                                        Text(_formatParticipants(
                                          task['participants'].isNotEmpty
                                              ? task['participants']
                                              : 'None',
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 50)
        ],
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
                  showTaskFormBottomSheet(context);
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
                  MaterialPageRoute(builder: (context) => HomePage()),
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
            const SizedBox(width: 56), // Empty space for the float button
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
                  MaterialPageRoute(
                      builder: (context) => const InformationCentre()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
