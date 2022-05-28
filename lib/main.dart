// ignore_for_file: prefer_const_constructors
import 'package:calendar/screens/login_screen.dart';
import 'package:calendar/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// google sign in:
// https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/

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
        home: LoginPage(),
      ),
    );
  }
}
