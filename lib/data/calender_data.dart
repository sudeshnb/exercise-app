import 'dart:collection';
import 'package:exercise_app/Core/calender/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final String min;
  final String kcal;
  final DateTime dateTime;
  const Event({
    required this.title,
    required this.min,
    required this.kcal,
    required this.dateTime,
  });
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  DateTime.utc(2022, 1, 6): [
    Event(
        dateTime: DateTime.utc(2022, 1, 6),
        title: 'Exercise for Beginners',
        min: '10',
        kcal: '58'),
    Event(
        dateTime: DateTime.utc(2022, 1, 6),
        title: 'Exercise for Advanced',
        min: '02',
        kcal: '5'),
  ],
  DateTime.utc(2022, 1, 8): [
    Event(
        dateTime: DateTime.utc(2022, 1, 8),
        title: 'Exercise for Beginners',
        min: '41',
        kcal: '58')
  ],
  DateTime.utc(2022, 1, 9): [
    Event(
        dateTime: DateTime.utc(2022, 1, 9),
        title: 'Exercise for Advanced',
        min: '41',
        kcal: '58')
  ],
  DateTime.utc(2022, 1, 12): [
    Event(
        dateTime: DateTime.utc(2022, 1, 12),
        title: 'Exercise for Beginners',
        min: '7',
        kcal: '74')
  ],
}..addAll({});

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
