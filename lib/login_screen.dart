import 'package:flutter/material.dart';
import 'package:pfe_app/home1.dart';
import 'package:pfe_app/pallete.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  late String passw;
  late String usern;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('assets/images/loginn.png'),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                usern=value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.borderColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.borderColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                passw=value;
              },
              obscureText: true,
              obscuringCharacter: '●',
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Enter your password.',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.borderColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.borderColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Pallete.gradient2,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async{
                    //Implement login functionality.
                    try{
                    final user =await _auth.signInWithEmailAndPassword(email: usern, password: passw);
                    if (user != null) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage1()),
                    );
                      
                    }}
                    catch(e){
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 56.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}