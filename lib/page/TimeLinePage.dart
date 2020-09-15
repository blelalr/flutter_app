import 'package:flutter/material.dart';

import 'package:flutter_app/model/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return StreamBuilder<QuerySnapshot>(
      stream: posts.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new Container(child:
            new Column(children: [
              headerView(Post.fromDocument(document)),
              contentView(Post.fromDocument(document)),
              // footerView(Post.fromDocument(document)),

            ],
            )
            ) ;
          }).toList(),
        );
      },
    );
  }

  Widget headerView(Post post) {

    return Text(post.authorUID);
  }

  Widget contentView(Post post) {
    return new Image.network(
        post.imageURL,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width*3/4,
        fit:BoxFit.cover
    );
  }
}
