import 'package:flutter/material.dart';
import 'package:flutter_app/model/Post.dart';
import 'package:flutter_app/widgets/PostWidget.dart';
import 'package:flutter_app/widgets/TextWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> tempArray = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "G",
    "H",
    "I",
    "J",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                padding: EdgeInsets.all(20),
                child:Container(
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 30, right: 0, bottom: 0),
                            child: Column(children: [
                              TextWidget("908", FontWeight.normal, 16),
                              TextWidget("貼文", FontWeight.normal, 16),
                            ]),
                          )),
                      Expanded(
                          child: Column(
                            children: [
                              TextWidget("167", FontWeight.normal, 16),
                              TextWidget("粉絲", FontWeight.normal, 16),
                            ],
                          )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 0, right: 30, bottom: 0),
                              child: Column(
                                children: [
                                  TextWidget("575", FontWeight.normal, 16),
                                  TextWidget("追蹤中", FontWeight.normal, 16),
                                ],
                              ))),
                    ],
                  ),
                )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 20, right: 0, bottom: 20),
                    child: TextWidget("我是查理布朗", FontWeight.normal, 16)
                ),
                Container(
                    color: Colors.white,
                    child: new GridView.builder(
                        shrinkWrap: true,
                        scrollDirection:Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.0),
                        itemCount: tempArray.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network('https://firebasestorage.googleapis.com/v0/b/instogram-12296.appspot.com/o/photos%2F-Ki9XbcRcZgFkhntqjAp.jpg?alt=media&token=0452e9c6-c1e5-4279-9e06-a8aff323d2b7',
                          fit: BoxFit.cover);

                        }))
              ],
            ));
  }
}
