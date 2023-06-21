import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/screens/calendar.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/screens/menu/feedback.dart';
import 'package:scholarly/modules/events.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scholarly/screens/habits_tab.dart';
import 'package:scholarly/screens/tasks_tab.dart';
import 'package:scholarly/screens/habits_tab.dart';
import 'package:scholarly/screens/tasks_form.dart';
import 'package:scholarly/screens/main_screen_menu.dart';
import 'package:scholarly/constants/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Task {
  final String title;
  final DateTime date;

  Task({required this.title, required this.date});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  late Map<DateTime, List<Task>> _tasks;
  late List<Task> _selectedTasks;

  late TabController? _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tasks = {};
    _selectedTasks = [];
    _retrieveTasksFromFirestore();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Future<void> _retrieveTasksFromFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('tasks').get();
      final List<Task> tasks = [];

      snapshot.docs.forEach((doc) {
        final title = doc.data()['title'] as String;
        final dateTimestamp = doc.data()['date'] as Timestamp?;

        // Perform null check for dateTimestamp
        final date = dateTimestamp != null ? dateTimestamp.toDate() : null;

        if (date != null) {
          tasks.add(Task(title: title, date: date));
        }
      });

      _tasks = _groupTasksByDate(tasks);
      setState(() {});
    } catch (e) {
      // Handle any errors that occur during task retrieval
      print('Error retrieving tasks: $e');
    }
  }

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final Map<DateTime, List<Task>> groupedTasks = {};
    for (final task in tasks) {
      final date = DateTime(task.date.year, task.date.month, task.date.day);
      if (groupedTasks.containsKey(date)) {
        groupedTasks[date]!.add(task);
      } else {
        groupedTasks[date] = [task];
      }
    }
    return groupedTasks;
  }

  List<Task> _getTasksForDate(DateTime date) {
    return _tasks[date] ?? [];
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      _selectedTasks = _getTasksForDate(selectedDate);
      _selectedDay = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar<Task>(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
              return _tasks[day] ?? [];
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, // Hide the format button
              titleTextStyle: TextStyle(fontSize: 20),
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
            ),
          ),
          SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Tasks'),
              Tab(text: 'Habits'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                TasksPage(selectedDay: _selectedDay),
                Habits_Page(),
              ],
            ),
          ),
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
                icon: Icon(Icons.add, color: Colors.white),
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
              icon: Icon(Icons.home),
              color: _currentPageIndex == 0
                  ? AppColors.kPrimary400
                  : AppColors.kMainText,
              onPressed: () {
                _changePage(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            SizedBox(width: 56), // Empty space for the float button
            IconButton(
              icon: Icon(Icons.school),
              color: AppColors.kMainText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassesPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.newspaper),
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
}
