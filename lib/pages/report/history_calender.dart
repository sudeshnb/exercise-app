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

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
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

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  var date = DateFormat.yMMMd('en_US')
                      .add_jm()
                      .format(value[index].dateTime);

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
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            value[index].title.toString(),
                            style: TextStyle(
                              color: black.withOpacity(0.6),
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
                            height: 20,
                            color: orange,
                          ),
                          Text('${value[index].min} min'),
                          w20,
                          Image.asset(
                            'assets/icons/time.png',
                            height: 20,
                            color: blue,
                          ),
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
                                  subTitle:
                                      'Are you sure you want to delete it?',
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
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
