// ignore_for_file: prefer_const_constructors

import 'package:calendar/screens/date.dart';
import 'package:calendar/screens/event_editor.dart';
import 'package:calendar/screens/login_screen.dart';
import 'package:calendar/utils/authentication.dart';
import 'package:calendar/utils/event.dart';
import 'package:calendar/utils/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
          leading: _isSigningOut
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : TextButton(
                  onPressed: () async {
                    setState(() {
                      _isSigningOut = true;
                    });
                    await Authentication.signOut(context: context);
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context)
                        .pushReplacement(_routeToSignInScreen());
                  },
                  child: Text("Sign Out"),
                ),
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
