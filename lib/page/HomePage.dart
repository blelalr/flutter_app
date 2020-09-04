import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/firebase/UserAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_app/model/Post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> _post;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _postsRef;
  StreamSubscription<Event> _postsStreamSubscription;
  DatabaseError _error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Flexible(
          child: FirebaseAnimatedList(
            query: _postsRef,

            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              return SizeTransition(
                sizeFactor: animation,
                child: _buildPostItem(_post[index])
              );
            },
          ),
        ),
      );

  }

  @override
  void initState() {
    super.initState();
    // Demonstrates configuring to the database using a file
    _postsRef = _database.reference().child("posts");
    _database.setPersistenceEnabled(true);
    _database.setPersistenceCacheSizeBytes(10000000);
    _postsRef.keepSynced(true);
    _postsStreamSubscription = _postsRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        Map<dynamic, dynamic> map = event.snapshot.value;
        _post =  map.values.toList() as List<Post>;
        print("${_post.toString()}");
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _postsStreamSubscription.cancel();
  }

  Future<void> _increment() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
        await _postsRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
  }

  Widget _buildPostItem(Post post) {
    return Column( children: [
      Text(post.authorUID??"")

    ]);
  }
}
// _postsRef.child(snapshot.key).remove()
// Widget _buildHomePage(int _counter, DatabaseError _error) {
//   return
// }


//
// child: OutlineButton(
//   child: Text('登出'),
//   onPressed: _btnOnSignOutClick,
// ),
void _btnOnSignOutClick() {
  UserAuth.signOut();
}
