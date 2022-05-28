// ignore_for_file: prefer_const_constructors

import 'package:calendar/screens/calendar_page.dart';
import 'package:calendar/utils/authentication.dart';
import 'package:calendar/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white54),
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
                  if (userCredential!.additionalUserInfo!.isNewUser) {
                    await DatabaseService(uid: user.uid).updateUserData(
                        "Neha's bday",
                        "It's neha's bdayyyyy!!!",
                        DateTime.now(),
                        DateTime.now().add(Duration(hours: 2)),
                        "Red",
                        true);
                  }
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
