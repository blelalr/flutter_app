import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:flutter_app/model/AppUser.dart';
import 'package:flutter_app/widgets/PostTileWidget.dart';
import 'package:flutter_app/widgets/TextWidget.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({this.post});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  AppUser _author;


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(widget.post.authorUID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {

        if (docSnapshot.hasError) {
          return Text("Something went wrong");
        }

        if (docSnapshot != null && docSnapshot.connectionState == ConnectionState.active) {
          _author = AppUser.fromDocument(docSnapshot.data);
          return new Column(children: [
            headerView(_author),
            contentView(),
            footerView(_author),
          ]);
        }

        return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
      },
    );
  }

  Widget headerView(AppUser author) {
    return new Container(
      child: buildPostHeader(author),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 50
    );
  }

  Widget contentView() {
    return new Image.network(
        widget.post.imageURL,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width*3/4,
        fit:BoxFit.cover
    );
  }

  Widget footerView(AppUser appUser) {
    return PostTile(post: widget.post, author: _author);
  }

  Widget buildPostHeader(AppUser author) {
    return Row(children: [
      Padding(
          padding: const EdgeInsets.only(
              left: 10, top: 0, right: 0, bottom: 0),
          child: new Image.network(author.photoUrl,
              width: 40, height: 40, fit: BoxFit.fitHeight)),
      Padding(
          padding: const EdgeInsets.only(
              left: 10, top: 0, right: 0, bottom: 0),
          child:TextWidget(author.username, FontWeight.bold, 18))
    ]);
  }

}

