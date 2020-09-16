import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/CreateAccountPage.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

class UserAuth extends StatefulWidget {
  @override
  _UserAuthState createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  bool _initialized = false;
  bool _error = false;
  User user;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
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
    if (_error) {
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
          user = snapshot.data;
          if (user == null) {
            return new Scaffold(body: SafeArea(child: LoginPage()));
          } else {
            return checkAccountExist();
          }
        } else {
          return Scaffold(
              body:
                  SafeArea(child: Center(child: CircularProgressIndicator())));
        }
      },
    );
  }

  Widget somethingWentWrong() {
    print("SomethingWentWrong");
    return Container();
  }

  Widget loading() {
    return Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator())));
  }

  void btnOnSignOutClick() {
    _UserAuthState().signOut();
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
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
    }
  }

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<DocumentSnapshot> isUserExist()  {
    try {
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
           .snapshots();

    } on FirebaseException catch (e) {
      print(e);
      return null;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Widget checkAccountExist() {
    return StreamBuilder<DocumentSnapshot>(
        stream: isUserExist(),
        builder: (context, docSnapshot) {
          print("checkAccountExist connectionState: ${docSnapshot.connectionState}");
          if (docSnapshot != null && docSnapshot.connectionState == ConnectionState.active) {
            print("checkAccountExist : ${docSnapshot.data.exists}");
            if(docSnapshot.data!= null && docSnapshot.data.exists) {
              return HomePage();
            } else {
              print("checkAccountExist : notExist");
              return CreateAccountPage();
            }
          } else {
            print("checkAccountExist connectionState: ${docSnapshot.connectionState}");
            return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
          }
        });
  }
}

