import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;

class PostTile extends StatefulWidget {
  final Post post;
  const PostTile({this.post});
  @override
  _PostTailState createState() => _PostTailState();
}

class _PostTailState extends State<PostTile> {
  bool _isLike;
  @override
  void initState() {
    // TODO: implement initState
    if(widget.post.like.length == 0) _isLike = false;
    _isLike = widget.post.like.contains(FirebaseUser.FirebaseAuth.instance.currentUser.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: buildPostFooter(widget.post),
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: 100
    );
  }
  Widget buildPostFooter(Post post) {
    return Row(children: [
      (_isLike)
          ? IconButton(icon: Icon(Icons.favorite), onPressed: () { unLikeThePost(post.nodeId);})
          : IconButton(icon: Icon(Icons.favorite_border), onPressed: () { likeThePost(post.nodeId);}),
      IconButton(icon: Icon(Icons.chat_bubble_outline)),
    ]);
  }

  void unLikeThePost(String nodeId) {
    setState(() {
      _isLike = false;
    });

    FirebaseFirestore.instance.collection('Posts').doc(nodeId)
        .update({'like' : FieldValue.arrayRemove([FirebaseUser.FirebaseAuth.instance.currentUser.uid])});
  }

  void likeThePost(String nodeId) {
    setState(() {
      _isLike = true;
    });
    FirebaseFirestore.instance.collection('Posts').doc(nodeId)
        .update({'like' : FieldValue.arrayUnion([FirebaseUser.FirebaseAuth.instance.currentUser.uid])});
  }

}
