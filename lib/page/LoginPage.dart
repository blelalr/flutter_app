import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/firebase/UserAuth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _etEmailController = TextEditingController();
  TextEditingController _etPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ListView(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 55),
              ),

                TextField(
                decoration: InputDecoration(
                  labelText: '帳號',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _etEmailController,
              ),

                TextField(
                  decoration: InputDecoration(
                    labelText: '密碼',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _etPasswordController,
                ),
              OutlineButton(
                  child: Text('登入'),
                  onPressed: () {
                    setState(() {
                      _btnOnLoginClick(
                          _etEmailController.text, _etPasswordController.text);
                    });
                  }),
              OutlineButton(
                child: Text('註冊'),
                onPressed: () {
                    setState(() {
                      _btnOnRegisterClick(_etEmailController.text, _etPasswordController.text);
                    });
              }),
              Row(
                children: [
                  IconButton(
                      iconSize: 30,
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: null),
                  IconButton(
                      iconSize: 30,
                      icon: FaIcon(FontAwesomeIcons.google),
                      onPressed: null),
                  IconButton(
                      iconSize: 30,
                      icon: FaIcon(FontAwesomeIcons.apple),
                      onPressed: null)
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  void _btnOnRegisterClick(String email, String password) {
    print(" Register Click");
    UserAuth().createState().registerWithEmailAndPassword(email, password);

  }

  void _btnOnLoginClick(String email, String password) {
    print(" Email:  $email \n Password:  $password");
    UserAuth().createState().signInWithEmailAndPassword(email, password);
  }
}
