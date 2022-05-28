import 'package:cloud_firestore/cloud_firestore.dart';
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
    final events = Provider.of<QuerySnapshot>(context);
    // print(events.docs);
    for (var doc in events.docs) {
      print(doc.data());
    }
    return Container();
  }
}
