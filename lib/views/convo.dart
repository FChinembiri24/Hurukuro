import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/constants.dart';
import 'package:kecy_mon_amour_chatapp/Services/messages.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

class MeetingRoom extends StatefulWidget {
  final String chatroomId;
  MeetingRoom(this.chatroomId);

  @override
  _MeetingRoomState createState() => _MeetingRoomState();
}

class _MeetingRoomState extends State<MeetingRoom> {
  Messages messages = new Messages();
  TextEditingController msg = new TextEditingController();
  late Stream msgStream;
  Widget convoList() {
    //TODO

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Chatroom")
            .doc(widget.chatroomId)
            .collection("chats")
            .orderBy("timeStamp", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MsgTile(
                  message: snapshot.data!.docs[index].get("message").toString(),
                  sendByMe:
                      snapshot.data!.docs[index].get("sendBy").toString() ==
                          Constants.myName,
                );
              },
            );
          } else
            return Container();
        });
  }

  sendMsg() {
    if (msg.text.isNotEmpty) {
      Map<String, dynamic> msgMap = {
        "message": msg.text,
        "sendBy": Constants.myName,
        "timeStamp": DateTime.now().microsecondsSinceEpoch,
      };
      msg.clear();
      Messages().addMessages(widget.chatroomId, msgMap).then(() {
        msg.clear();
      });
    }
  }

  @override
  void initState() {
    messages.getMessages(widget.chatroomId).then((value) {
      setState(() {
        msgStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomId
            .toString()
            .replaceAll("_", "")
            .replaceAll(Constants.myName, "")),
      ),
      body: Container(
        child: Stack(
          children: [
            convoList(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: msg,
                      style: wordStyle(),
                      decoration: InputDecoration(
                          hintText: "Tumira shoko",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMsg();
                        msg.clear();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgTile extends StatelessWidget {
  // const msgTile({Key key}) : super(key: key);

  late final String message;
  late final bool sendByMe;

  MsgTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
