import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/CreateAccountPage.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
          _user = snapshot.data;
          if (_user == null) {
            return new Scaffold(body: SafeArea(child: LoginPage()));
          } else if (true) {
            return SafeArea(
                child: new Scaffold(
              appBar: new AppBar(
                  actions: <Widget> [
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          signOut();
                        })
                  ],
                  title: Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 30),
              )),
              body: HomePage(),
            ));
          } else {
            return SafeArea(
                child: new Scaffold(
              appBar: new AppBar(
                  title: Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 30),
              )),
              body: CreateAccountPage(),
            ));
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
    print("Loading");
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
}

// Future<void> isUserAccountExist(User user) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(user.uid)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         return true;
//       } else {
//         return false;
//       }
//     });
//   } on FirebaseException catch (e) {
//     print(e);
//   } catch(e) {
//     print(e.toString());
//   }
// }
