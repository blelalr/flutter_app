import 'package:firebase_database/firebase_database.dart';

class Post {
  String nodeId;
  String authorUID;
  String email;
  String imagePath;
  String imageURL;
  String postDate;
  String postDateReverse;

  Post(this.nodeId, this.authorUID, this.email, this.imagePath,
      this.imageURL, this.postDate, this.postDateReverse);

  Post.fromSnapshot(DataSnapshot snapshot) :
        nodeId = snapshot.key,
        authorUID = snapshot.value["authorUID"],
        email = snapshot.value["email"],
        imagePath = snapshot.value["authorUID"],
        imageURL = snapshot.value["imageURL"],
        postDate = snapshot.value["postDate"],
        postDateReverse = snapshot.value["postDateReverse"];

  Post.fromJson(Map<dynamic, dynamic> json) :
        authorUID = json['authorUID'],
        email = json['email'],
        imagePath = json['imagePath'],
        imageURL = json['imageURL' ] ,
        postDate = json['postDate']   ,
        postDateReverse = json['postDateReverse'];

  Map<dynamic, dynamic> toJson() =>
    {
      'authorUID': authorUID,
      'email': email,
      'imagePath' : imagePath,
      'imageURL' : imageURL,
      'postDate' : postDate ,
      'postDateReverse' : postDateReverse,
    };

}