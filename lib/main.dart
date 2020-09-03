// Create an infinite scrolling lazily loaded list

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/firebase/UserAuth.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return UserAuth();
  }

}
