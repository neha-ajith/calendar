import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  Event(
      {required this.title,
      this.isAllDay = false,
      required this.backgroundColor,
      this.description = "An event.",
      required this.from,
      required this.to});
}
