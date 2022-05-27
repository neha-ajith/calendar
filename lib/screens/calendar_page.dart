// ignore_for_file: prefer_const_constructors

import 'package:calendar/screens/date.dart';
import 'package:calendar/screens/event_editor.dart';
import 'package:calendar/utils/event.dart';
import 'package:calendar/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventEditor()));
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: SfCalendar(
          onTap: (calendarTapDetails) => showDialog(
              context: context, builder: (context) => Date(calendarTapDetails)),
          dataSource: EventDataSource(_getDataSource()),
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
        )));
  }

  List<Event> _getDataSource() {
    final provider = Provider.of<EventProvider>(context);
    return provider.events;
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return appointments![index].backgroundColor;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
