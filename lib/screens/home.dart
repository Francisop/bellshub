import 'package:bellshub/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:bellshub/screens/qrcode.dart';
import 'package:bellshub/screens/hookup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dm/chat_rooms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final pages = [
    ChatRooms(),
    Hookup(),
    QrCode(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        backgroundColor: Colors.white,
        fixedColor: Colors.indigo[900],
        elevation: 0.0,
        iconSize: 27,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(
              Icons.dashboard,
              color: (_currentIndex == 0) ? Colors.indigo : Colors.grey[600],
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: 'hookup',
            icon: FaIcon(FontAwesomeIcons.kissWinkHeart,
                color: (_currentIndex == 1) ? Colors.indigo : Colors.grey[600],
                size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Qrcode',
            icon: FaIcon(FontAwesomeIcons.qrcode,
                color: (_currentIndex == 2) ? Colors.indigo : Colors.grey[600],
                size: 25),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: FaIcon(Icons.settings,
                color: (_currentIndex == 3) ? Colors.indigo : Colors.grey[600],
                size: 25),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
