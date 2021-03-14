import 'package:bellshub/screens/chat_rooms.dart';
import 'package:bellshub/screens/dashboard.dart';
import 'package:bellshub/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationModel {
  IconData navicon;
  String navRoute;
  Color navColor;


  CustomNavigationModel({
    this.navColor,
    this.navRoute,
    this.navicon
  });
  // Icons.dashboard,
  //   Icons.adb,
  //   Icons.party_mode,
  //   Icons.settings_applications
}

  List<CustomNavigationModel> customNav = [
    CustomNavigationModel(
      navColor: Colors.red,
      navRoute: '/',
      navicon:Icons.dashboard 
    ),
    CustomNavigationModel(
      navColor: Colors.orange,
      navRoute: '/settings',
      navicon:Icons.adb, 
    ),
    CustomNavigationModel(
      navColor: Colors.orange,
      navRoute: '/',
    //  navRoute: MaterialPageRoute(builder: (_) => ()),
      navicon:FontAwesomeIcons.restroom, 
    ),
    CustomNavigationModel(
      navColor: Colors.orange,
      navRoute: '/settings',
    //  navRoute: MaterialPageRoute(builder: (_) => Settings()),
      navicon:Icons.settings_applications, 
    ),
  ];