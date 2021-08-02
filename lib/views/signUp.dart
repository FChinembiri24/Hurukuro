import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Services/auth.dart';
import 'package:kecy_mon_amour_chatapp/views/chats.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget{
 final Function toggle;

  SignUp(this.toggle) ;

  _SignUpState createState() =>_SignUpState();
}

class _SignUpState extends State<SignUp>{
  
  bool isLoading=false;
  AuthMeths authMeths=new AuthMeths();
  final formKey=GlobalKey<FormState>();
  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();
   TextEditingController pass1=new TextEditingController();
   TextEditingController name=new TextEditingController();
   

  signMeUp()
{
  if(formKey.currentState!.validate())
  {setState((){

      isLoading=true;
      });
    authMeths.signUpWithEmailP(user.text, pass.text).then((value) => print(value));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Chats()   ));
  }
}

  Widget build(BuildContext context){
  return Scaffold(
    appBar:appBarMain(context),
    body:isLoading?  Container(
      child:Center(child: CircularProgressIndicator(),),
    )
    : Container(
      
        alignment: Alignment.bottomCenter,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: Column(
            
            mainAxisSize:MainAxisSize.min ,
            children: [
              Form(
                key: formKey,
                                  child: Column(
                  children: [
    SizedBox(height: 30,),
     TextFormField(
                      style: wordStyle(),
                      controller:name,
                      validator: (val){
                        return val!.length < 2 ? "Enter Username 2+ characters" : null;
                      },
                      decoration: textDeco("username"),
                    ),
    TextFormField(
      controller: user,
      style: wordStyle(),
      decoration: textDeco("email")
      ,
       validator: (val){
                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?  null : "Enter correct email";}
      ),
      
    
    TextFormField(
      obscureText: true,
      controller: pass,
      style: wordStyle(),
       validator:  (val){
         return val!.length < 6 ? "Enter Password 6+ characters" : null;
                },
      decoration: textDeco("password"
      ),
      ),

      SizedBox(height:8,),
      TextFormField(
        obscureText: true,
        controller: pass1,
      style: wordStyle(),
       validator:  (val){
         if(pass==pass1)
                  return  "Passwords do not match" ;
          else 
            return null;
                  
                },
      decoration: textDeco("repeat password"
      ),
      ),
      
      SizedBox(height:8,
      ),
     
                  SizedBox(height:8
                  ),
                  GestureDetector(
                    onTap: () {
                      //TODO
                      signMeUp();
                    },
                                          child: Container(
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
    child: Text("Sign Up", style: wordStyle2(),
                    ),
                    ),
                  ),
                  SizedBox(height:30),
                   GestureDetector(
                     onTap: () => authMeths,

                                        child: Container(
    alignment:Alignment.center,
    width:MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical:20),
    decoration: BoxDecoration(
      color: Colors.red ,
                          borderRadius: BorderRadius.circular(30),
      
                  ),
    child: Text("Sign up with Google", style: wordStyle2(),
                  ),
                  ),
                   ),

          SizedBox(height:16
          ),
          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
    Text(
      "Don't have an account",
      style: wordStyle(),
    ),
    GestureDetector(
      onTap: (){
        final Function toggle;

        SignUp(this.toggle) ;
      }
      ,
          child: Container(
        padding: EdgeInsets.symmetric(vertical:8),
        child: Text("Sign in now",
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
            ],
          ),
        ),
      ) ,
  );
  
  }
}