
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/firebase/UserAuth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: new Scaffold(
          appBar: new AppBar(
              actions: <Widget> [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.signOutAlt),
                    onPressed: () {
                      UserAuth().createState().signOut();
                    })
              ],
              title: Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 30),
              )),
          body: homePageBody(),
        ));
  }

  Widget homePageBody() {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    return StreamBuilder<QuerySnapshot>(
      stream: posts.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));;
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['authorUID']),
              subtitle: new Text(document.data()['imageURL']),
            );
          }).toList(),
        );
      },
    );
  }
}