import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:flutter_app/model/User.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({this.post});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      headerView(widget.post),
      contentView(widget.post),
      footerView(widget.post),
    ]);
  }

  Widget headerView(Post post) {
    return new Container(
      child: buildPostHeader(post.authorUID),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 50
    );
  }

  Widget contentView(Post post) {
    return new Image.network(
        post.imageURL,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width*3/4,
        fit:BoxFit.cover
    );
  }

  Widget footerView(Post post) {
    return new Container(
        child: buildPostFooter(post),
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: 100
    );

  }

  Widget buildPostHeader(String authorUID) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(authorUID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          User user = User.fromDocument(snapshot.data);
          return Row(children: [
            Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 0, right: 0, bottom: 0),
                child: new Image.network(user.photoUrl,
                    width: 40, height: 40, fit: BoxFit.fitHeight)),
            Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 0, right: 0, bottom: 0),
                child: Text(user.username, style: TextStyle(fontSize: 20.0)))
          ]);
        }

        return Text("loading");
      },
    );
  }

  Widget buildPostFooter(Post post) {
    return Row(children: [
    (post.like.contains(FirebaseUser.FirebaseAuth.instance.currentUser.uid)
        ? IconButton(icon: Icon(Icons.favorite), onPressed: () { unLikeThePost(post.nodeId);})
        : IconButton(icon: Icon(Icons.favorite_border), onPressed: () { likeThePost(post.nodeId);})),
      IconButton(icon: Icon(Icons.chat_bubble_outline)),
    ]);
  }

  void unLikeThePost(String nodeId) {

  }

  void likeThePost(String nodeId) {

  }
}

