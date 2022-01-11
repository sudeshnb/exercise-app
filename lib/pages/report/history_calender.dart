import 'dart:collection';
import 'package:exercise_app/Core/calender/table_calendar.dart';
import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/calender_data.dart';

class HistoryCalender extends StatefulWidget {
  const HistoryCalender({Key? key}) : super(key: key);

  @override
  _HistoryCalenderState createState() => _HistoryCalenderState();
}

class _HistoryCalenderState extends State<HistoryCalender> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  final CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
//is used no data from weeks
  bool isDataHas = true;
  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    // return eventData;
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;

      _selectedDays.clear();
      _selectedEvents.value = [];
      _selectedDays.add(selectedDay);
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  String monthSet(int index) {
    String setMount = '';
    switch (index) {
      case 1:
        setMount = 'Jan';
        break;
      case 2:
        setMount = 'Feb';
        break;
      case 3:
        setMount = 'Mar';
        break;
      case 4:
        setMount = 'Apr';
        break;
      case 5:
        setMount = 'May';
        break;
      case 6:
        setMount = 'Jun';
        break;
      case 7:
        setMount = 'Jul';
        break;
      case 8:
        setMount = 'Aug';
        break;
      case 9:
        setMount = 'Sep';
        break;
      case 10:
        setMount = 'Oct';
        break;
      case 11:
        setMount = 'Nov';
        break;

      default:
        setMount = 'Dec';
        break;
    }
    return setMount;
  }

  @override
  Widget build(BuildContext context) {
    var day = _focusedDay.subtract(const Duration(days: 6));
    return Column(
      children: [
        TableCalendar<Event>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          selectedDayPredicate: (day) {
            // Use values from Set to mark multiple days as selected
            return _selectedDays.contains(day);
          },
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        h10,
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '       ${monthSet(day.month)} ${day.day.toString()}',
                          style: TextStyle(
                            color: black.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        w10,
                        Text(
                          '-',
                          style: TextStyle(
                            color: black.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        w10,
                        Text(
                          "${monthSet(_focusedDay.month)} ${_focusedDay.day.toString()}",
                          style: TextStyle(
                            color: black.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    isDataHas == true
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: eventData.length,
                                itemBuilder: (itemBuilder, index) {
                                  var date = DateFormat.yMMMd('en_US')
                                      .add_jm()
                                      .format(eventData[index].dateTime);
                                  return eventListTile(
                                      date, eventData, index, context);
                                }),
                          )
                        : Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                color: black.withOpacity(0.4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "       ${monthSet(value[0].dateTime.month)} ${value[0].dateTime.day}",
                      style: TextStyle(
                        color: black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          var date = DateFormat.yMMMd('en_US')
                              .add_jm()
                              .format(value[index].dateTime);

                          return eventListTile(date, value, index, context);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Container eventListTile(
      String date, List<Event> value, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: blueShadow.withOpacity(0.3),
            offset: const Offset(0, 0),
            blurRadius: 20,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: blue,
          child: Image.asset(
            'assets/icons/done.png',
            height: 20,
            color: white,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                color: black.withOpacity(0.4),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            h5,
            Text(
              value[index].title.toString(),
              style: TextStyle(
                color: black.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/gas.png',
              height: 15,
              color: orange,
            ),
            w5,
            Text('${value[index].min} min'),
            w20,
            Image.asset(
              'assets/icons/time.png',
              height: 18,
              color: blue,
            ),
            w5,
            Text('${value[index].kcal} Kcal'),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (builder) {
                  return AppDialog(
                    title: 'Delete',
                    subTitle: 'Are you sure you want to delete it?',
                    onContinue: () {
                      setState(() => value.removeAt(index));
                      Navigator.pop(context);
                    },
                  );
                });
          },
          icon: const Icon(Icons.more_vert_outlined),
        ),
      ),
    );
  }
}

List<Event> eventData = [
  Event(
      dateTime: DateTime.utc(2022, 1, 8),
      title: 'Exercise for Beginners',
      min: '41',
      kcal: '58'),
  Event(
      dateTime: DateTime.utc(2022, 1, 12),
      title: 'Exercise for Beginners',
      min: '7',
      kcal: '74'),
  Event(
      dateTime: DateTime.utc(2022, 1, 9),
      title: 'Exercise for Advanced',
      min: '41',
      kcal: '58')
];
