import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String nodeId;
  final String authorUID;
  final String authorUserName;
  final String postContent;
  final String imagePath;
  final String imageURL;
  final List postLikes;
  final String postDate;
  final String postDateReverse;

  Post({this.nodeId, this.authorUID, this.authorUserName, this.postContent, this.imagePath,
      this.imageURL, this.postLikes, this.postDate, this.postDateReverse});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
        nodeId : doc.id,
        authorUID : doc.data()['authorUID'],
        authorUserName : doc.data()['authorUserName'],
        imagePath : doc.data()['imagePath'],
        imageURL : doc.data()['imageURL'],
        postContent: doc.data()['postContent'],
        postLikes: doc.data()['postLikes'],
        postDate : doc.data()['postDate'],
        postDateReverse : doc.data()['postDateReverse']
    );
  }

}