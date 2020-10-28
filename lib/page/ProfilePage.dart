import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:flutter_app/widgets/TextWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return buildProfilePage();
  }
}

Widget buildProfilePage() {
  CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  return FutureBuilder<QuerySnapshot>(
    future: posts.where('authorUID', isEqualTo: FirebaseAuth.instance.currentUser.uid ).get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
      }
      return Container(
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                  padding:
                  EdgeInsets.only(top: 10, left: 20, right: 0, bottom: 10),
                  child: Container(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/instogram-12296.appspot.com/o/userphotos%2F%E4%B8%8B%E8%BC%89.jpeg?alt=media&token=def4cffd-ddc5-4756-8fce-5201b6d166c1',
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top:20),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 0, left: 20, right: 0, bottom: 2),
                                            child: Column(children: [
                                              TextWidget("908", FontWeight.normal, 14),
                                              TextWidget("貼文", FontWeight.normal, 14),
                                            ]),
                                          )),
                                      Expanded(
                                          child: Column(
                                            children: [
                                              TextWidget("167", FontWeight.normal, 14),
                                              TextWidget("粉絲", FontWeight.normal, 14),
                                            ],
                                          )),
                                      Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 0,
                                                  right: 20,
                                                  bottom: 0),
                                              child: Column(
                                                children: [
                                                  TextWidget(
                                                      "575", FontWeight.normal, 14),
                                                  TextWidget(
                                                      "追蹤中", FontWeight.normal, 14),
                                                ],
                                              ))),
                                    ]),
                                    OutlineButton(
                                        onPressed: updateProfile(),
                                        child: TextWidget(
                                            "          更新個人資料          ", FontWeight.normal, 12))
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
              Padding(
                  padding:
                  EdgeInsets.only(top: 0, left: 20, right: 0, bottom: 20),
                  child: TextWidget("我是查理布朗", FontWeight.normal, 16)),

              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Image.network(
                        Post.fromDocument(document).imageURL,
                        fit: BoxFit.cover);
                  }).toList(),

              )
            ],
          ));
    },
  );
}

updateProfile() {}
