import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/Post.dart';

class FirestoreService {
// Create the controller that will broadcast the posts
  final StreamController<List<Post>> _postsController = StreamController<List<Post>>.broadcast();

  final CollectionReference _postsCollectionReference = FirebaseFirestore.instance.collection('Posts');

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => Post.fromDocument(snapshot))
            .where((mappedItem) => mappedItem.nodeId != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _postsController.stream;
  }

}