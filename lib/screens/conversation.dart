import 'package:flutter/material.dart';

class Converstion extends StatefulWidget {
  @override
  _ConverstionState createState() => _ConverstionState();
}

class _ConverstionState extends State<Converstion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: Text('Conversation room'),
        //   centerTitle: true,
        // )
        body: Container(
            child: Stack(
          children: [
            Container(
              // child: chatMessageList(),
              padding: EdgeInsets.only(bottom: 50),
            ),
            // SizedBox(height: 50,),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          // controller: _messageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left:30),
                            hintText: 'Message...',
                            hintStyle: TextStyle(color: Colors.red),
                            border: InputBorder.none,
                            // fillColor: Colors.grey,
                          ),
                        ),
                      ),
                    
                      Container(
                          // height: 10,
                          child: CircleAvatar(child: Icon(Icons.send))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
