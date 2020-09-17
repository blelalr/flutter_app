import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String profileName;
  final String username;
  final String photoUrl;
  final String email;
  final String bio;

  AppUser({
    this.id,
    this.profileName,
    this.username,
    this.photoUrl,
    this.email,
    this.bio,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      id: doc.id,
      email: doc.data()['email'],
      username: doc.data()['username'],
      photoUrl: doc.data()['url'],
      profileName: doc.data()['displayName'],
      bio: doc.data()['bio'],
    );
  }
}