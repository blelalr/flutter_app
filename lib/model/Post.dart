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
        authorUID : doc.get("authorUID"),
        description: doc.get("description"),
        email : doc.get("email"),
        imagePath : doc.get("imagePath"),
        imageURL : doc.get("imageURL"),
        postDate : doc.get("postDate"),
        postDateReverse : doc.get("postDateReverse")
    );
    
  }

}