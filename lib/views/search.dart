import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/constants.dart';
import 'package:kecy_mon_amour_chatapp/Services/UserSearch.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

import 'convo.dart';

class Search extends StatefulWidget {
  //Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = new TextEditingController();
  SearchMeths searchMeths = new SearchMeths();
  late QuerySnapshot searchSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  /*= await FirebaseFirestore.instance
      .collection("User")
      .where("name", isEqualTo: "franko")
      .get();*/

  //create Chatroom

  chatroomStart(String username) {
    List<String> users = [username, Constants.myName];
    String chatRoomId = getChatRoomId(username, Constants.myName);
    Map<String, dynamic> chatroomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    searchMeths.createChatroom(chatRoomId, chatroomMap);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MeetingRoom(chatRoomId)));
  }

  Widget searchTile(
    String userName,
    String userEmail,
  ) {
    // ignore: todo
    //TODO
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white60,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: wordStyle2(),
            ),
            Text(
              userEmail,
              style: wordStyle2(),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            // ignore: todo
            //TODO
            // create chatroom, and send user to conversation screen use push replacement
            chatroomStart(userName);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.lightBlue[500],
              borderRadius: BorderRadius.circular(35),
            ),
            child: Text("Chat"),
          ),
        )
      ]),
    );
  }

  initiateSearch() async {
    if (search.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await searchMeths.getUser(search.text).then((val) {
        setState(() {
          searchSnapshot = val;
          print("$searchSnapshot");
          setState(() {
            isLoading = false;
            haveUserSearched = true;
          });
        });
      });
    }
  }

  Widget searchList() {
    // ignore: unnecessary_null_comparison
    if (isLoading == false) {
      return haveUserSearched
          ? ListView.builder(
              itemCount: searchSnapshot.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return searchTile(
                    searchSnapshot.docs[index].get("name").toString(),
                    searchSnapshot.docs[index].get("email").toString());
              })
          : Container(child: CircularProgressIndicator());
    } else
      return Container(
        color: Colors.amberAccent,
        child: Text("Nothing"),
      );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, Constants.myName + " find colleagues"),
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
            color: Colors.blueGrey[800],
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                        decoration: textDeco("Search"), controller: search)),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
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
                      child: Image.asset("assets/search_white.png")),
                ),
              ],
            ),
          ),
          searchList()
        ],
      )),
    );
  }
}

//class SearchTile extends StatelessWidget {
//const SearchTile({Key key}) : super(key: key);
/*  final String userName;
  final String userEmail;
  SearchTile(this.userName, this.userEmail);
  @override
  Widget build(BuildContext context) {
    return 
  }*/
//}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
