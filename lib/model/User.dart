import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileName;
  final String username;
  final String url;
  final String email;
  final String bio;

  User({
    this.id,
    this.profileName,
    this.username,
    this.url,
    this.email,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc.get('email'),
      username: doc.get('username'),
      url: doc.get('photoUrl'),
      profileName: doc.get('displayName'),
      bio: doc.get('bio'),
    );
  }
}