import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(52), topRight: Radius.circular(52)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.home,size: 30,),
                onPressed: () {},
                color: Colors.blueGrey[200],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.chat_bubble_outline_sharp,size: 30,),
                onPressed: () {},
                color: Colors.blueGrey[200],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.rv_hookup,size: 30,),
                onPressed: () {},
                color: Colors.blueGrey[200],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.notifications,size: 30,),
                onPressed: () {},
                color: Colors.blueGrey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
