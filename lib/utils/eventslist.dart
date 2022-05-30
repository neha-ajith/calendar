import 'package:calendar/utils/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<Event>>(context);

    events.forEach((event) {
      print(event.title);
    });

    return Container();
  }
}
