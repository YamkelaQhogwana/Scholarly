import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:scholarly/constants/custom_appbar.dart';
import 'package:scholarly/modules/events.dart';
import 'package:scholarly/screens/home.dart';
import 'package:scholarly/screens/classes.dart';
import 'package:scholarly/screens/info.dart';
import 'package:scholarly/modules/events.dart' as EventsModule;
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _CalendarPageState extends State<CalendarPage> {
  final ValueNotifier<List<EventsModule.Event>> _selectedEvents =
      ValueNotifier([]);

  DateTime _currentMonth = DateTime.now();
  List<EventsModule.Event> events = getDummyEvents();
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    _selectedEvents.value = getDummyEvents()
        .where((event) => isSameDay(event.date, selectedDay))
        .toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Helper function to get the Color from a string representation
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

  String _formatParticipants(List<String> participants) {
    if (participants.length <= 1) {
      return participants.join(', ');
    } else {
      return "${participants[0]} +${participants.length - 1}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            TableCalendar<EventsModule.Event>(
              firstDay: DateTime.utc(2000, 01, 01),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _currentMonth,
              calendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(
                    color: AppColors.kMainText, fontWeight: FontWeight.w600),
                weekendTextStyle: const TextStyle(
                    color: AppColors.kDarkGray, fontWeight: FontWeight.w600),
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                    color: AppColors.kPrimary300,
                    borderRadius: BorderRadius.circular(15)),
                markerDecoration: const BoxDecoration(
                    color: AppColors.kPrimary400, shape: BoxShape.circle),
              ),
              eventLoader: (day) => getDummyEvents()
                  .where((event) => isSameDay(event.date, day))
                  .toList(),
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => _selectedDays.contains(day),
              onDaySelected: _onDaySelected,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(color: AppColors.kDarkGray),
                formatButtonVisible: false,
                leftChevronIcon: Icon(Icons.chevron_left_rounded,
                    color: AppColors.kMainText),
                rightChevronIcon: Icon(Icons.chevron_right_rounded,
                    color: AppColors.kMainText),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: AppColors.kMainText),
                weekendStyle: TextStyle(color: AppColors.kDarkGray),
              ),
              onPageChanged: (date) {
                setState(() {
                  _currentMonth = date;
                });
              },
            ),
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
                  List<EventsModule.Event> eventsForMonth = events
                      .where((event) => event.date.month == _currentMonth.month)
                      .toList();

                  return ListView.builder(
                    itemCount: eventsForMonth.length,
                    itemBuilder: (context, index) {
                      EventsModule.Event event = eventsForMonth[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0 ||
                              event.date.day !=
                                  eventsForMonth[index - 1].date.day)
                            // Render the day as the title with horizontal line
                            ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    DateFormat('EEEE, MMMM d')
                                        .format(event.date),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: AppColors.kDarkGray),
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors
                                          .kDarkGray, // Customize the color of the line
                                      thickness:
                                          1, // Customize the thickness of the line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final startTime = DateTime(
                                    event.date.year,
                                    event.date.month,
                                    event.date.day,
                                    event.startTime.hour,
                                    event.startTime.minute,
                                  );
                                  final endTime = DateTime(
                                    event.date.year,
                                    event.date.month,
                                    event.date.day,
                                    event.endTime.hour,
                                    event.endTime.minute,
                                  );
                                  final duration =
                                      endTime.difference(startTime);

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
                                              IconButton(
                                                onPressed: () {
                                                  // Edit button action
                                                },
                                                icon: const Iconify(
                                                    MaterialSymbols
                                                        .edit_square_outline_rounded,
                                                    size: 20,
                                                    color: AppColors.kDarkGray),
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
                                            event.title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)} '
                                            '(${duration.inHours}h ${duration.inMinutes.remainder(60)}m)',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
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
                                                    event.venue,
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
                                                    _formatParticipants(
                                                        event.participants),
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
                                              // Task complete action
                                            },
                                            child: const Text('Task Complete'),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty
                                                  .all<Color>(AppColors
                                                      .kPrimary400), // Set background color
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0), // Set zero border radius
                                                ),
                                              ),
                                              minimumSize: MaterialStateProperty
                                                  .all<Size>(
                                                const Size(double.infinity,
                                                    0), // Take full width of dialog
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
                                                    color: AppColors.kDarkGray),
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
                                  DateFormat('hh:mm').format(DateTime(
                                    event.date.year,
                                    event.date.month,
                                    event.date.day,
                                    event.startTime.hour,
                                    event.startTime.minute,
                                  )),
                                ),
                                Text(
                                  DateFormat('hh:mm').format(DateTime(
                                    event.date.year,
                                    event.date.month,
                                    event.date.day,
                                    event.endTime.hour,
                                    event.endTime.minute,
                                  )),
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _getColorFromString(event
                                              .cateColour), // Use the mapping to get the color
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        event.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Iconify(Octicon.location,
                                          size: 15, color: AppColors.kDarkGray),
                                      const SizedBox(width: 4),
                                      Text(event.venue),
                                      const SizedBox(width: 10),
                                      const Iconify(Bi.person,
                                          size: 20, color: AppColors.kDarkGray),
                                      const SizedBox(width: 4),
                                      Text(_formatParticipants(
                                          event.participants)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index == eventsForMonth.length - 1)
                            const SizedBox(
                                height:
                                    30), // Add some space at the bottom of the last event
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: kBottomNavigationBarHeight / 2,
              left: (MediaQuery.of(context).size.width - 56) /
                  2, // Adjust the left position
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors
                      .kPrimary400, // Set your desired button color here
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
                  onPressed: () {
                    // Placeholder code for add button
                    print('Add button pressed');
                  },
                  icon: const Icon(Icons.add,
                      color: Colors.white), // Set the icon color
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
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()),
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
                    MaterialPageRoute(builder: (context) => const InfoPage()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
