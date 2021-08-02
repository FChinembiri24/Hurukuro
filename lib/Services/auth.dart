import 'package:firebase_auth/firebase_auth.dart';



    


class AuthMeths
{

  final FirebaseAuth _auth= FirebaseAuth.instance;
  
  

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
 
 Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}