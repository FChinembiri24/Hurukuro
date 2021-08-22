import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/Authenticat.dart/Authanticate.dart';
import 'package:kecy_mon_amour_chatapp/Helper/constants.dart';
import 'package:kecy_mon_amour_chatapp/Helper/helperFunctions.dart';
import 'package:kecy_mon_amour_chatapp/Services/auth.dart';
import 'package:kecy_mon_amour_chatapp/views/search.dart';

class Chats extends StatefulWidget {
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chats> {
  String username = "";
  AuthMeths use = new AuthMeths();

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello " + Constants.myName),
          actions: [
            GestureDetector(
              onTap: () {
                use.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Authenticater(),
                    ));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.exit_to_app_rounded)),
            )
          ],
          elevation: 0.0,
          centerTitle: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search()));
          },
          child: Icon(Icons.search_outlined),
        ));
  }
}
