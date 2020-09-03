import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/firebase/UserAuth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }
}

Widget _buildHomePage() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
    child: Center(
      child: OutlineButton(
        child: Text('登出'),
        onPressed: _btnOnSignOutClick,
      ),
    ),
  );
}

void _btnOnSignOutClick() {
  UserAuth.signOut();
}
