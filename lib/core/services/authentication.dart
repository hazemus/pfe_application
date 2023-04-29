import 'package:flutter/material.dart';

class Authentication{
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future loginWithEmailAndPassword({
  required String email @require String password
}) async {
  try {
 var userData = await _firebaseAuth.signInWithEmailAndPassword(
  email: email, password: password
 );
 return userData.user;
  } catch (e) {
    if (e is FirebaseAuthException){
      return e;
    }
  }
}
}
  
