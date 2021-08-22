import 'package:cloud_firestore/cloud_firestore.dart';

class SearchMeths {
  getUser(String username) async {
    return await FirebaseFirestore.instance
        .collection("User")
        //  .doc("owOxaK5cz8gOfB6AGbkG")
        .where("name", isEqualTo: username)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("User")
        //  .doc("owOxaK5cz8gOfB6AGbkG")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadInfo(userMap) {
    FirebaseFirestore.instance.collection("User").add(userMap);
  }

  upload(String email, String name) {
    FirebaseFirestore.instance
        .collection("User")
        .add({'name ': name, 'email': email});
  }

  createChatroom(String chatRoomId, chatroomMap) {
    FirebaseFirestore.instance
        .collection("Chatroom")
        .doc(chatRoomId)
        .set(chatroomMap)
        .catchError((e) {
      print(e.toString);
    });
  }
}
