import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';



    


class AuthMeths
{
  
  final FirebaseAuth _auth= FirebaseAuth.instance;
  AuthMeths()
  {
    Firebase.initializeApp();
  }
  

  Future signInWithEmailP(String email,String pass) async{

    try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
        
        return userCredential.user != null ? userCredential.user : null;
    }
   catch(e){
    print(e.toString());
  }
  }

   Future signUpWithEmailP(String email,String pass) async{

    try{
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
        
        return userCredential.user != null ? userCredential.user : null;
    }
   catch(e){
    print(e.toString());
  }
  }

  Future resetPass(String email ) async
  {
    try{

      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }

  }
/*Future<User> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;

    if (result == null) {
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
    }
  }*/
 Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}