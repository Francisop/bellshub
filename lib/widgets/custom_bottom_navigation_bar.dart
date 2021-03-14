import 'package:bellshub/models/custom_navigation_model.dart';
import 'package:bellshub/screens/settings.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var active = false;
  // List<IconData> widgetIconCount = [
  //   Icons.dashboard,
  //   Icons.adb,
  //   Icons.party_mode,
  //   Icons.settings_applications
  // ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(52), topRight: Radius.circular(52)),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: customNav.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        customNav[i].navicon,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentIndex = i;
                        });
                        // (customNav[_currentIndex].navRoute != customNav[i].navRoute) ? 
                        Navigator.pushNamed(context, customNav[i].navRoute);



                        print(ModalRoute.of(context).settings.name);

                      },
                      color: Colors.blueGrey[200],
                    ),
                    (_currentIndex == i)
                        ? Container(
                            height: 4, width: 50, color: customNav[i].navColor)
                        : SizedBox.shrink(),
                  ],
                ),
              );
            }),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Container(
        //       child: Column(
        //         children: [
        //           IconButton(
        //             icon: Icon(
        //               Icons.dashboard,
        //               size: 30,
        //             ),
        //             onPressed: () {},
        //             color: Colors.blueGrey[200],
        //           ),
        //           (active == true)
        //               ? Container(height: 0.3, width: 50, color: Colors.red)
        //               : Container(),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       child: Column(
        //         children: [
        //           IconButton(
        //             icon: Icon(
        //               FontAwesomeIcons.adn,
        //               size: 30,
        //             ),
        //             onPressed: () {},
        //             color: Colors.blueGrey[200],
        //           ),
        //           Container(height: 0.3, width: 50, color: Colors.red),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       child: Column(
        //         children: [
        //           IconButton(
        //             icon: Icon(
        //               Icons.rv_hookup,
        //               size: 30,
        //             ),
        //             onPressed: () {},
        //             color: Colors.blueGrey[200],
        //           ),
        //           Container(height: 0.3, width: 50, color: Colors.red),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       child: Column(
        //         children: [
        //           IconButton(
        //             icon: Icon(
        //               Icons.settings,
        //               size: 30,
        //             ),
        //             onPressed: () {
        //               setState(() {
        //                 active = true;
        //               });
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (_) => Settings()));
        //             },
        //             color: Colors.blueGrey[200],
        //           ),
        //           (active == true)
        //               ? Container(height: 0.3, width: 50, color: Colors.red)
        //               : Container(),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  // Widget htj() {
  //   return ListView.builder(
  //       itemCount: widgetIconCount.length,
  //       itemBuilder: (context, i) {
  //         return Container(
  //           child: Column(
  //             children: [
  //               IconButton(
  //                 icon: Icon(
  //                   widgetIconCount[i],
  //                   size: 30,
  //                 ),
  //                 onPressed: () {
  //                   setState(() {
  //                     _currentIndex = i;
  //                   });
  //                   Navigator.push(
  //                       context, MaterialPageRoute(builder: (_) => Settings()));
  //                 },
  //                 color: Colors.blueGrey[200],
  //               ),
  //               (_currentIndex == i)
  //                   ? Container(height: 0.3, width: 50, color: Colors.red)
  //                   : SizedBox.shrink(),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
