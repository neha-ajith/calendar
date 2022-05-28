// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar/utils/authentication.dart';
import 'package:calendar/utils/sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Calendar", style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return SignInButton();
                }
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
