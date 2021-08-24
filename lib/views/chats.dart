import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/Authenticat.dart/Authanticate.dart';
import 'package:kecy_mon_amour_chatapp/Helper/constants.dart';
import 'package:kecy_mon_amour_chatapp/Helper/helperFunctions.dart';
import 'package:kecy_mon_amour_chatapp/Helper/theme.dart';
import 'package:kecy_mon_amour_chatapp/Services/auth.dart';
import 'package:kecy_mon_amour_chatapp/Services/messages.dart';
import 'package:kecy_mon_amour_chatapp/views/convo.dart';
import 'package:kecy_mon_amour_chatapp/views/search.dart';

class Chats extends StatefulWidget {
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chats> {
  String username = "";
  AuthMeths use = new AuthMeths();
  Messages messages = new Messages();
  late QuerySnapshot roomStream;

  Widget meetingRoomList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Chatroom")
            .where("users", arrayContains: Constants.myName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return MeetingRoomTile(
                          userName: snapshot.data!.docs[index]
                              .get("chatRoomId")
                              .toString()
                              .replaceAll("_", "")
                              .replaceAll(Constants.myName, ""),
                          meetingRoomId: snapshot.data!.docs[index]
                              .get("chatRoomId")
                              .toString());
                    },
                  )
                : Container();
        });
  }

  @override
  void initState() {
    getInfo();
    /*  messages.getMeetingRooms().then((value) {
      roomStream = value;
      setState(() {});
    });*/

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
        body: meetingRoomList(),
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

class MeetingRoomTile extends StatelessWidget {
  // const MeetingRoomTile({Key key}) : super(key: key);
  final String userName;
  final String meetingRoomId;

  MeetingRoomTile({required this.userName, required this.meetingRoomId});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MeetingRoom(meetingRoomId)));
        },
        child: Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: CustomTheme.colorAccent,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(userName.substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(userName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 1,
      )
    ]);
  }
}
