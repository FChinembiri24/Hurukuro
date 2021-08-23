import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kecy_mon_amour_chatapp/Helper/constants.dart';

class Messages {
  addMessages(String chatroomID, msgMap) {
    FirebaseFirestore.instance
        .collection("Chatroom")
        .doc(chatroomID)
        .collection("chats")
        .add(msgMap);
  }

  getMessages(String chatroomID) async {
    return await FirebaseFirestore.instance
        .collection("Chatroom")
        .doc(chatroomID)
        .collection("chats")
        .snapshots();
  }

  getMeetingRooms() {
    return FirebaseFirestore.instance
        .collection("Chatroom")
        .where("users", arrayContains: Constants.myName)
        .snapshots();
  }
}
