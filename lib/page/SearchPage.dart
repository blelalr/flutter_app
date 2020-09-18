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
    return new ListView(
      children: tempArray
          .asMap()
          .map((index, type) {
            return MapEntry(index,
                new Container(child: UserResult(tempArray, index, type)));
          })
          .values
          .toList(),
    );
  }
}

class UserResult extends StatelessWidget {
  int _index;
  String _type;
  List<String> _tempArray;

  UserResult(this._tempArray, this._index, this._type);

  @override
  Widget build(BuildContext context) {
    if (_type == "U") {
      return unreadItemView(context);
    } else {
      return seenItemView(context);
    }
  }

  Widget unreadItemView(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                1
              ], colors: [
                // Colors.red,
                // Colors.orange,
                Color(int.parse('FFF3F6FA', radix: 16)),
                Color(int.parse('FFFFFFFF', radix: 16)),
              ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42.0),
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(42.0),
              )),
        ),
        Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                1
              ], colors: [
                // Colors.orange,
                // Colors.red
                Color(int.parse('FFFFFFFF', radix: 16)),
                Color(int.parse('FFF3F6FA', radix: 16)),
              ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(42.0),
                bottomLeft: Radius.circular(42.0),
                bottomRight: Radius.zero,
              )),
        ),
      ],
    );
  }

  Widget seenItemView(BuildContext context) {
    if (_tempArray[_index - 1] == "U" && _tempArray[_index + 1] == "S") {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(int.parse('FFFFFFFF', radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42.0),
                  topRight: Radius.zero,
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(42.0),
                )),
          ),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(int.parse('FFF3F6FA', radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(42.0),
                  bottomLeft: Radius.circular(42.0),
                  bottomRight: Radius.zero,
                )),
          ),
        ],
      );
    }
    else {
      return Stack(
        children: [
          Container(
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 100.0,
                        color: Color(int.parse('FFF3F6FA', radix: 16)),
                      ),
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Color(int.parse('FFF3F6FA', radix: 16)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                                width: 4,
                                color: Color(int.parse('FFFFFFFF', radix: 16)),
                                style: BorderStyle.solid)),
                      ),
                      Container(
                        height: 4.0,
                        color: Color(int.parse('FFF3F6FA', radix: 16)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 100,
                    color: Color(int.parse('FFF3F6FA', radix: 16)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 100.0,
                        color: Color(int.parse('FFF3F6FA', radix: 16)),
                      ),
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Color(int.parse('FFF3F6FA', radix: 16)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(32.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                                width: 4,
                                color: Color(int.parse('FFFFFFFF', radix: 16)),
                                style: BorderStyle.solid)),
                      ),
                      Container(
                        height: 4.0,
                        color: Color(int.parse('FFF3F6FA', radix: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   child: Flex(
          //     direction: Axis.horizontal,
          //     children: <Widget>[
          //       Expanded(
          //         flex: 1,
          //         child: Container(
          //           alignment: Alignment.topRight,
          //           height: 100.0,
          //           color: Colors.transparent,
          //         ),
          //       ),
          //       Expanded(
          //           flex: 5,
          //           child: Stack(alignment: Alignment.topCenter, children: [
          //             Container(
          //               height: 100,
          //               color: Color(int.parse('FFF3F6FA', radix: 16)),
          //             ),
          //             Container(
          //               height: 4,
          //               color: Color(int.parse('FFFFFFFF', radix: 16)),
          //             ),
          //           ])),
          //       Expanded(
          //         flex: 1,
          //         child: Container(
          //           alignment: Alignment.topRight,
          //           height: 100.0,
          //           color: Colors.transparent,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      );
    }
  }
}
