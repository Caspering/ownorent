// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/ui/user_home_view.dart';
import 'package:ownorent/ui/views/appointments_view.dart';
import 'package:ownorent/ui/views/favorites_view.dart';
import 'package:ownorent/ui/views/feed_view.dart';
import 'package:ownorent/ui/views/not_logged_view.dart';
import 'package:ownorent/ui/views/profile_view.dart';
import 'package:ownorent/ui/views/user_house_view.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../shared/avatar.dart';
import 'map.dart';

class AppIndex extends StatefulWidget {
  const AppIndex({super.key});

  @override
  State<AppIndex> createState() => _AppIndexState();
}

class _AppIndexState extends State<AppIndex> {
  int currentIndex = 0;
  List<Widget> children = [
    //find homes
    Mapview(),
    //feed
    FeedView(),

    //my home
    UserHomeView(),
    //profile
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    List<Widget> children = [
      //find homes
      Mapview(),
      //feed
      FeedView(),

      //my home
      _auth.authState == true ? UserHomeView() : NotLogged(),
      //profile
      _auth.authState == true ? ProfileView() : NotLogged()
    ];
    return Scaffold(
      appBar: currentIndex == 0
          ? AppBar(
              leading: Avatar(),
              backgroundColor: ownorentWhite,
              elevation: 0.0,
            )
          : null,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ownorentWhite,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: ownorentWhite,
          selectedItemColor: ownorentRed,
          unselectedItemColor: ownorentPurple,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 5.0,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
                label: "Find homes",
                icon: Icon(
                  Icons.search_outlined,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: "Feed",
                icon: Icon(
                  Icons.feed_outlined,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: "My homes",
                icon: Icon(
                  Icons.home_outlined,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(
                  Icons.person_outlined,
                  size: 20,
                ))
          ],
          onTap: onTabTapped,
        ),
      ),
      body: children[currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
