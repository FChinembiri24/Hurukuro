import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/Authenticat.dart/Authanticate.dart';
import 'package:kecy_mon_amour_chatapp/Services/auth.dart';


class Chats extends StatefulWidget{
  _ChatState  createState() => _ChatState() ;
}

class _ChatState extends State<Chats>{
  String username="";
  AuthMeths use=new AuthMeths();
  Widget build(BuildContext context){
    return Scaffold(appBar:  AppBar(
    title:Text("TaskChat Hello "+username
     
     
    ),
    actions: [
      GestureDetector(
        onTap: (){
            use.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticater()  ,));
        },
              child: Container(
          padding: EdgeInsets.symmetric(horizontal:14),
          child: Icon(Icons.exit_to_app_rounded)),
      )
    ],
    elevation: 0.0,
    centerTitle: false,

    ),
    );
  }



  }