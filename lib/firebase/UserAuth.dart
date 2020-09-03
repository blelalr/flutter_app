import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

class UserAuth extends StatefulWidget {
  @override
  _UserAuthState createState() => _UserAuthState();

  static void signInWithEmailAndPassword(String email, String password) {
    _UserAuthState().signInWithEmailAndPassword(email, password);
  }
  static void signOut() {
    _UserAuthState().signOut();
  }

}

class _UserAuthState extends State<UserAuth> {
  bool _initialized = false;
  bool _error = false;
  User _user;


  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return somethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return loading();
    }

    return mainApp();

  }


  Widget mainApp() {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            _user = snapshot.data;
            if (_user == null) {
              return new Scaffold(body: SafeArea(child: LoginPage()));
            }
            return new Scaffold(body: SafeArea(child: HomePage()));
          } else {
            return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
          }
        },
    );

  }

  Widget somethingWentWrong() {
    print("SomethingWentWrong");
  }

  Widget loading() {
    print("Loading");
    return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    print(" Email:  $email \n Password:  $password");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}