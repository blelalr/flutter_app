import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileName;
  final String username;
  final String photoUrl;
  final String email;
  final String bio;

  User({
    this.id,
    this.profileName,
    this.username,
    this.photoUrl,
    this.email,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc.data()['email'],
      username: doc.data()['username'],
      photoUrl: doc.data()['url'],
      profileName: doc.data()['displayName'],
      bio: doc.data()['bio'],
    );
  }
}