import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/AppUser.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter_app/widgets/TextWidget.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final AppUser author;
  const PostTile({this.post, this.author});
  @override
  _PostTailState createState() => _PostTailState();
}

class _PostTailState extends State<PostTile> {
  bool _isLike;
  @override
  void initState() {
    // TODO: implement initState
    if(widget.post.postLikes.length == 0) _isLike = false;
    _isLike = widget.post.postLikes.contains(FirebaseUser.FirebaseAuth.instance.currentUser.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Wrap(
      children: [
        new Container(
            child: buildPostFooter(widget.post),
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            ),
      ],
    );
  }

  Widget buildPostFooter(Post post) {
    return new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        (_isLike)
            ? IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  unLikeThePost(post.nodeId);
                })
            : IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  likeThePost(post.nodeId);
                }),
        IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
      ]),
      Container(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
          child: TextWidget(widget.author.username, FontWeight.bold, 16)
      ),

      Container(
        padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
        child: TextWidget(widget.post.postContent, FontWeight.normal, 16),
        height: 84,
      )
    ]);
  }

  void unLikeThePost(String nodeId) {
    setState(() {
      _isLike = false;
    });

    FirebaseFirestore.instance.collection('Posts').doc(nodeId)
        .update({'postLikes' : FieldValue.arrayRemove([FirebaseUser.FirebaseAuth.instance.currentUser.uid])});
  }

  void likeThePost(String nodeId) {
    setState(() {
      _isLike = true;
    });
    FirebaseFirestore.instance.collection('Posts').doc(nodeId)
        .update({'postLikes' : FieldValue.arrayUnion([FirebaseUser.FirebaseAuth.instance.currentUser.uid])});
  }

}
