import 'package:flutter/material.dart';

import 'package:flutter_app/model/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/widgets/PostWidget.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return buildTimeLinePage();
  }

  Widget buildTimeLinePage() {
    CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
    return FutureBuilder<QuerySnapshot>(
      future: posts.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new Container(child: PostWidget(post: Post.fromDocument(document)));
          }).toList(),
        );
      },
    );
  }

}
