
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/firebase/UserAuth.dart';
import 'package:flutter_app/page/NotificationsPage.dart';
import 'package:flutter_app/page/ProfilePage.dart';
import 'package:flutter_app/page/SearchPage.dart';
import 'package:flutter_app/page/TimeLinePage.dart';
import 'package:flutter_app/page/UploadPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Scaffold(
          appBar: new AppBar(
              actions: <Widget> [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.signOutAlt),
                    onPressed: () {
                      UserAuth().createState().signOut();
                    })
              ],
              title: Text(
                'Flutter App',
                style: GoogleFonts.playball(fontSize: 30),
              )),
          body: buildHomeBody(),
          bottomNavigationBar: buildHomeBottom(),
        ));
  }

  onPageChangeListener(int pageIndex){
    setState(() {
      this.currentPageIndex = pageIndex;
    });
  }

  Widget buildHomeBody() {
    return PageView(
      children: [
        TimeLinePage(),
        SearchPage(),
        UploadPage(),
        NotificationsPage(),
        ProfilePage()
      ],
      controller: pageController,
      onPageChanged: onPageChangeListener,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget buildHomeBottom() {
    return CupertinoTabBar(
      currentIndex: currentPageIndex,
      onTap:onTapPageChange,
      activeColor: Colors.black54,
      inactiveColor: Colors.black12,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon:Icon(Icons.home)),
        BottomNavigationBarItem(icon:Icon(Icons.search)),
        BottomNavigationBarItem(icon:Icon(Icons.photo_camera)),
        BottomNavigationBarItem(icon:Icon(Icons.favorite)),
        BottomNavigationBarItem(icon:Icon(Icons.person)),
      ],
    );
  }


  onTapPageChange(int pageIndex) {
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve:Curves.bounceInOut);
  }
}