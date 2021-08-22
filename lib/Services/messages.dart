import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  getMessages(String chatroomID, msgMap) {
    FirebaseFirestore.instance
        .collection("Chatroom")
        .doc(chatroomID)
        .collection("chats")
        .add(msgMap);
  }
}
