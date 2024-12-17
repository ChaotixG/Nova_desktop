import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_state.dart';

/// Concrete State: Calendar State
class CalendarState extends AppState {
  final Function(AppState) onStateChange;

  const CalendarState({super.key, required this.onStateChange});

  @override
  Widget build(BuildContext context) {
    return CalendarView(onStateChange: onStateChange);
  }
}

/// Stateful Widget for Calendar UI
class CalendarView extends StatefulWidget {
  final Function(AppState) onStateChange;

  const CalendarView({super.key, required this.onStateChange});

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  late final ValueNotifier<List<String>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController eventController = TextEditingController();
        return AlertDialog(
          title: Text("Add Event"),
          content: TextField(
            controller: eventController,
            decoration: InputDecoration(hintText: "Enter event title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (eventController.text.isNotEmpty) {
                  setState(() {
                    final dateKey = DateTime(
                      _selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
                    _events[dateKey] ??= [];
                    _events[dateKey]?.add(eventController.text);
                  });
                  _selectedEvents.value = _getEventsForDay(_selectedDay!);
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar UI"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent, // Correct argument order
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 8.0), // Replace Container with SizedBox for spacing
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return Center(child: Text("No events for this day."));
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            final day = _selectedDay!;
                            _events[DateTime(day.year, day.month, day.day)]?.removeAt(index);
                            _selectedEvents.value = _getEventsForDay(day);
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
