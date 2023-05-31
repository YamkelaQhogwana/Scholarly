import 'package:flutter/material.dart';

class Event {
  final String title;
  final String category;
  final String cateColour;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String venue;
  final List<String> participants;
  final bool repeat;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.participants,
    required this.repeat,
    required this.cateColour,
  });
}

List<Event> getDummyEvents() {
  final List<Event> events = [
      Event(
      title: 'ITECA Lecture',
      category: 'Lecture',
      date: DateTime(2023, 5, 1),
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 11, minute: 0),
      venue: 'A107',
      participants: ['Mr. John Doe'],
      repeat: true,
      cateColour: 'kGreenDark',
    ),
    Event(
      title: 'ITMDA Lecture',
      category: 'Lecture',
      date: DateTime(2023, 5, 2),
      startTime: TimeOfDay(hour: 14, minute: 30),
      endTime: TimeOfDay(hour: 16, minute: 30),
      venue: 'A108',
      participants: ['Mr. Adamn Park'],
      repeat: true,
      cateColour: 'kGreenDark',
    ),
    Event(
      title: 'ITOOA Lecture',
      category: 'Lecture',
      date: DateTime(2023, 5, 2),
      startTime: TimeOfDay(hour: 10, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      venue: 'A107',
      participants: ['Mr. Lorem Ipsum'],
      repeat: true,
      cateColour: 'kGreenDark',
    ),
    Event(
      title: 'Movie Night',
      category: 'Social',
      date: DateTime(2023, 6, 1),
      startTime: TimeOfDay(hour: 18, minute: 0),
      endTime: TimeOfDay(hour: 21, minute: 0),
      venue: 'Cinema Hall',
      participants: ['John Doe', 'Jane Smith', 'Alice Brown'],
      repeat: false,
      cateColour: 'kRedDark',
    ),
    Event(
      title: 'Mandela Day',
      category: 'Public Holiday',
      date: DateTime(2023, 7, 18),
      startTime: TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay(hour: 23, minute: 59),
      venue: 'N/A',
      participants: [],
      repeat: false,
      cateColour: 'kPurpleDark',
    ),
  ];

  return events;
}
