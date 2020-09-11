import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/firebase/UserAuth.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController _etUserId = TextEditingController();

  @override
  Widget build(BuildContext parentContext) {
    return SafeArea(
        child: new Scaffold(
          appBar: new AppBar(
              title: Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 30),
              )),
          body: createAccountPage(),
        ));
  }

  Widget createAccountPage() {
    return  Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
      child: Column(
          children: [
            Text("使用者名稱:"),
            TextField(
              decoration: InputDecoration(
                hintText: "英數混合字元",
              ),
              keyboardType: TextInputType.name,
              controller: _etUserId,)
            ,
            OutlineButton(
                child: Text('建立'),
                onPressed: () {
                  setState(() {
                    return _btnOnCreateUserClick(_etUserId.text);
                  });
                }
            ),
          ]),
    );
  }

  Future<void> _btnOnCreateUserClick(String userName) async {
    User currentUser = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.doc('Users/${currentUser.uid}');
    await users
        .set({
          'profileName': currentUser.displayName,
          'username': userName,
          'url': currentUser.photoURL,
          'email': currentUser.email,
          'bio': ''
        })
        .catchError((error) => print("Failed to add user: $error"));
  }
}
