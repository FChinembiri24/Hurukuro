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
  Widget chatListener() {
    //TODO
    return Container();
  }

  sendMsg() {
    Map<String, String> msgMap = {
      "message": msg.text,
      "sendBy": Constants.myName
    };
    messages.getMessages(widget.chatroomId, msgMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Stack(
          children: [
            //chatMessages(),
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
                      //controller: messageEditingController,
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
                        // addMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
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
                        child: Icon(Icons.send_sharp),
                      ),
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
