import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Services/UserSearch.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

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
  /* chatroomStart(String username){
      List<String> users=[userName,myName

      ];
     searchMeths.createChatroom(chatRoomId, chatroomMap)
  }*/
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
                return SearchTile(
                    searchSnapshot.docs[index].get("name").toString(),
                    searchSnapshot.docs[index].get("email").toString());
              })
          : Container(child: CircularProgressIndicator());
    } else
      return Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
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

class SearchTile extends StatelessWidget {
  //const SearchTile({Key key}) : super(key: key);
  final String userName;
  final String userEmail;
  SearchTile(this.userName, this.userEmail);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
            //TODO
            // create chatroom, and send user to conversation screen use push replacement
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.lightBlue[900],
              borderRadius: BorderRadius.circular(35),
            ),
            child: Text("Chat"),
          ),
        )
      ]),
    );
  }
}
