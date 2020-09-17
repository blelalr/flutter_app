import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:flutter_app/model/User.dart';
import 'package:flutter_app/widgets/PostTileWidget.dart';

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
    return PostTile(post: post);
  }

  Widget buildPostHeader(String authorUID) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(authorUID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {

        if (docSnapshot.hasError) {
          return Text("Something went wrong");
        }

    if (docSnapshot != null && docSnapshot.connectionState == ConnectionState.active) {
          User user = User.fromDocument(docSnapshot.data);
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

}

