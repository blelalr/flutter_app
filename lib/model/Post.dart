import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String nodeId;
  final String authorUID;
  final String description;
  final String email;
  final String imagePath;
  final String imageURL;
  final String postDate;
  final String postDateReverse;

  Post({this.nodeId, this.authorUID, this.description,this.email, this.imagePath,
      this.imageURL, this.postDate, this.postDateReverse});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
        nodeId : doc.id,
        authorUID : doc.data()['authorUID'],
        description: doc.data()['description'],
        email : doc.data()['email'],
        imagePath : doc.data()['imagePath'],
        imageURL : doc.data()['imageURL'],
        postDate : doc.data()['postDate'],
        postDateReverse : doc.data()['postDateReverse']
    );
    
  }

}