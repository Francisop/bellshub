import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(52),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child:
                          IconButton(icon: Icon(Icons.home), onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.chat_bubble_outline_sharp),
                          onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.rv_hookup), onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.notifications), onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}