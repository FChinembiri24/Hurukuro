import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kecy_mon_amour_chatapp/Helper/helperFunctions.dart';
import 'package:kecy_mon_amour_chatapp/Services/UserSearch.dart';
import 'package:kecy_mon_amour_chatapp/Services/auth.dart';
import 'package:kecy_mon_amour_chatapp/widgets/widget.dart';

import 'chats.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMeths authMeths = new AuthMeths();
  SearchMeths searchMeths = new SearchMeths();
  late QuerySnapshot info;

  signMeIn() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(user.text);
      setState(() {
        isLoading = true;
      });
      authMeths.signInWithEmailP(user.text, pass.text).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Chats()));
          searchMeths.getUserByEmail(user.text).then((val) {
            info = val;
            HelperFunctions.saveUserNameSharedPreference(
                info.docs[0].get("name"));
          });
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Welcome back"),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: user,
                          style: wordStyle(),
                          decoration: textDeco("email"),
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Enter correct email";
                          }),
                      TextFormField(
                        controller: pass,
                        style: wordStyle(),
                        decoration: textDeco("password"),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text("forgot password?", style: wordStyle())),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => signMeIn(),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Sign In",
                      style: wordStyle2(),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign In with Google",
                    style: wordStyle2(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: wordStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register now", style: wordStyle4()),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 160),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
