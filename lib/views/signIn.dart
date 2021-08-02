import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

class SignIn extends StatefulWidget
{
   final Function toggle;

  SignIn(this.toggle);


  _SignInState createState() => _SignInState();

}

class _SignInState extends State<SignIn>
{
  Widget build(BuildContext context)
  {
      return Scaffold(
        appBar: appBarMain(context),
        body:Container(
          
            alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24
              ),
              child: Column(
                
                mainAxisSize:MainAxisSize.min ,
                children: [
        SizedBox(height: 30,),
        TextField(
          style: wordStyle(),
          decoration: textDeco("email")
          ,
          ),
          
        
        TextField(
          style: wordStyle(),
          
          decoration: textDeco("password"
          ),
          ),
          SizedBox(height:8,
          ),
          Container(
            alignment: Alignment.centerRight,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal:16,vertical:8
            )
            ,
            child:Text("forgot password?", style: wordStyle())
          ),
          ),
                SizedBox(height:8
                ),
                Container(
        alignment:Alignment.center,
        width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical:20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:  [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],) ,
                      borderRadius: BorderRadius.circular(30),
          
                ),
        child: Text("Sign In", style: wordStyle2(),
                ),
                ),
                SizedBox(height:30),
                 Container(
        alignment:Alignment.center,
        width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical:20),
        decoration: BoxDecoration(
          color: Colors.red ,
                      borderRadius: BorderRadius.circular(30),
          
                ),
        child: Text("Sign In with Google", style: wordStyle2(),
                ),
                ),

              SizedBox(height:16
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        Text(
          "Have an account ",
          style: wordStyle(),
        ),
        GestureDetector(
          onTap: (){
            
             widget.toggle;
          },
                  child: Container(
            padding: EdgeInsets.symmetric(vertical:8),
            child: Text("Register now",
            style:wordStyle4()
            ),
          ),
        )
                ],
                ),

                SizedBox(height:160)  ,

                ],
              ),
            ),
          ) ,

      );
  }

}