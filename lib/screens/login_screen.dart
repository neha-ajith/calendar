// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar/screens/calendar_page.dart';
import 'package:calendar/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class SignInButton extends StatefulWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21))),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await Authentication.signInWithGoogle(context: context);
                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => Calendar(
                              user: user,
                            )),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/google.png", height: 40),
                    Text(
                      "Sign In With Google",
                      style: TextStyle(fontSize: 19, color: Colors.black),
                    ),
                  ],
                ),
              )),
    );
  }
}
