import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

class SignIn extends StatefulWidget
{

  _SignInState createState() => _SignInState();

}

class _SignInState extends State<SignIn>
{
  Widget build(BuildContext context)
  {
      return Scaffold(
        appBar: appBarMain(context),
        body:Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "email",
                    hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
          ),
                ),
                
              
              TextField(
                decoration: InputDecoration(hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
          ),
                )
                

            
              

            ],
          ),
        ) ,

      );
  }

}