import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../color_reference.dart';
import '../app_state.dart';
import 'dart:collection';

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
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _currentIndex = 1; // Default to month view

  final LinkedHashMap<DateTime, List<Event>> _events = LinkedHashMap();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController eventController = TextEditingController();
        String? recurrence;
        Color? eventColor;

        return AlertDialog(
          title: const Text("Add Event"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: eventController,
                decoration: const InputDecoration(hintText: "Enter event title"),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Recurrence"),
                items: const [
                  DropdownMenuItem(value: "Daily", child: Text("Daily")),
                  DropdownMenuItem(value: "Weekly", child: Text("Weekly")),
                  DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
                  DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
                ],
                onChanged: (value) => recurrence = value,
              ),
              DropdownButtonFormField<Color>(
                decoration: const InputDecoration(labelText: "Event Color"),
                items: [
                  DropdownMenuItem(value: Colors.red, child: Text("Red")),
                  DropdownMenuItem(value: Colors.blue, child: Text("Blue")),
                  DropdownMenuItem(value: Colors.green, child: Text("Green")),
                  DropdownMenuItem(value: Colors.purple, child: Text("Purple")),
                ],
                onChanged: (value) => eventColor = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (eventController.text.isNotEmpty) {
                  setState(() {
                    final dateKey = DateTime(
                      _selectedDay!.year,
                      _selectedDay!.month,
                      _selectedDay!.day,
                    );
                    _events[dateKey] ??= [];
                    _events[dateKey]?.add(Event(
                      title: eventController.text,
                      recurrence: recurrence,
                      color: eventColor ?? Colors.blue,
                    ));
                  });
                  _selectedEvents.value = _getEventsForDay(_selectedDay!);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _searchEvents() {
    showSearch(
      context: context,
      delegate: EventSearchDelegate(events: _events),
    );
  }

  Widget _buildYearView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = DateTime(_focusedDay.year, index + 1, 1);
        return GestureDetector(
          onTap: () {
            setState(() {
              _focusedDay = month;
              _currentIndex = 1;
            });
          },
          child: Card(
            child: Center(
              child: Text(
                "${month.month}/${month.year}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthView() {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2022, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: _getEventsForDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _selectedEvents.value = _getEventsForDay(selectedDay);
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3,
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return const Center(child: Text("No events for this day."));
              }
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(value[index]),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          label: 'Delete',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {
                            setState(() {
                              _events[_selectedDay!]?.removeAt(index);
                              _selectedEvents.value = _getEventsForDay(_selectedDay!);
                            });
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(value[index].title),
                      subtitle: Text(value[index].recurrence ?? "One-time event"),
                      trailing: CircleAvatar(
                        backgroundColor: value[index].color,
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

  Widget _buildWeekView() {
    final startOfWeek = _focusedDay.subtract(Duration(days: _focusedDay.weekday - 1));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        final day = startOfWeek.add(Duration(days: index));
        final events = _getEventsForDay(day);
        return GestureDetector(
          onTap: () {
            setState(() {
              _focusedDay = day;
              _currentIndex = 3;
            });
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${day.day}"),
                if (events.isNotEmpty)
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 5,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayView() {
    final events = _getEventsForDay(_focusedDay);
    return Column(
      children: [
        Text(
          "Day: ${_focusedDay.toLocal().toString().split(' ')[0]}",
          style: const TextStyle(fontSize: 18),
        ),
        if (events.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].title),
                  subtitle: Text(events[index].recurrence ?? "One-time event"),
                  trailing: CircleAvatar(
                    backgroundColor: events[index].color,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildScheduleView() {
    List<Event> allEvents = _events.values.expand((e) => e).toList();
    allEvents.sort((a, b) => a.title.compareTo(b.title));
    return ListView.builder(
      itemCount: allEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(allEvents[index].title),
          subtitle: Text(allEvents[index].recurrence ?? "One-time event"),
          trailing: CircleAvatar(
            backgroundColor: allEvents[index].color,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchEvents,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addEvent,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildYearView(),
          _buildMonthView(),
          _buildWeekView(),
          _buildDayView(),
          _buildScheduleView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryColor, // Set color for the selected label and icon
        unselectedItemColor: AppColors.primaryColor, // Set color for the unselected label and icon
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
            label: "Year",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_view_month, color: AppColors.primaryColor),
            label: "Month",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_view_week, color: AppColors.primaryColor),
            label: "Week",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.today, color: AppColors.primaryColor),
            label: "Day",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list, color: AppColors.primaryColor),
            label: "Schedule",
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String? recurrence;
  final Color color;

  Event({
    required this.title,
    this.recurrence,
    required this.color,
  });
}

class EventSearchDelegate extends SearchDelegate<Event?> {
  final LinkedHashMap<DateTime, List<Event>> events;

  EventSearchDelegate({required this.events});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = events.values
        .expand((e) => e)
        .where((event) => event.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return const Center(
        child: Text("No events found."),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final event = searchResults[index];
        return ListTile(
          title: Text(event.title),
          subtitle: Text(event.recurrence ?? "One-time event"),
          trailing: CircleAvatar(
            backgroundColor: event.color,
          ),
          onTap: () {
            close(context, event); // Return the selected event
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = events.values
        .expand((e) => e)
        .where((event) => event.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final event = suggestions[index];
        return ListTile(
          title: Text(event.title),
          onTap: () {
            query = event.title;
            showResults(context);
          },
        );
      },
    );
  }
}