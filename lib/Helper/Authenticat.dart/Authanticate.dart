import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/views/signIn.dart';
import 'package:kecy_mon_amour_chatapp/views/signUp.dart';

class Authenticater extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticater> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
