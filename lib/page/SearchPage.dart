import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> tempArray = [
    "U",
    "U",
    "U",
    "S",
    "S",
    "S",
    "U",
    "S",
    "U",
    "S",
    "S"
  ];

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListView.builder(
          itemCount: tempArray.length,
          itemBuilder: (BuildContext context, int index ) {
            if (tempArray[index] == "U") {
              return unreadItemView(context);
            } else {
              return seenItemView(context);
            }
          })
    );
  }

  Widget unreadItemView(BuildContext context) {
    return new Align(
        alignment: Alignment.topLeft,
        heightFactor: 0.5,
          child: new ClipPath(
              clipper: MyClipper(),
              child: Container(
                  height: 180.0,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topRight, stops: [
                    0.5,
                    1
                  ], colors: [
                    // Colors.red,
                    // Colors.orange,
                    Color(int.parse('FFF3F6FA', radix: 16)),
                    Color(int.parse('FFFFFFFF', radix: 16)),
                  ]))))
    );
  }

  Widget seenItemView(BuildContext context) {
    return new Align(
        alignment: Alignment.topLeft,
        heightFactor: 0.58,
        child: new ClipPath( clipper:  MyClipper(),
        child: Container(
          height: 180.0,
          color: Color(int.parse('FFF3F6FA', radix: 16))
        ))
    );
  }
}

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width - 40, 40);
    //從右上角開始
    path.lineTo(40, 40);
    //向左連線至曲線起始點 //上直線
    path.quadraticBezierTo(0, 40, 0, 0);
    //畫出左上角的曲線
    path.lineTo(0, size.height - 80);
    //向下連線至曲線起始點 //左直線
    path.quadraticBezierTo(0, size.height - 40, 40,  size.height - 40);
    //畫出左下角的曲線
    path.lineTo(size.width - 40, size.height - 40);
    //向右連線至曲線起始點 //下直線
    path.quadraticBezierTo(size.width, size.height - 40, size.width,  size.height);
    //畫出右下角的曲線
    path.lineTo(size.width , 80);
    //向上連線至曲線起始點 //右直線
    path.quadraticBezierTo(size.width, 40, size.width - 40,  40);
    //畫出右上角的曲線
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }


  }

