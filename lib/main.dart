// ignore_for_file: prefer_const_constructors

// https://medium.com/flutter-community/flutter-use-google-calendar-api-adding-the-events-to-calendar-3d8fcb008493

import 'package:calendar/screens/calendar_page.dart';
import 'package:calendar/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: Colors.grey),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              primary: Colors.white,
            ))),
        title: 'Calendar',
        home: Calendar(),
      ),
    );
  }
}
