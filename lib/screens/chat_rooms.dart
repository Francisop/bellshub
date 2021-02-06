import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          child: ListTile(
            title: Text('Ositadinma'),
            subtitle: Text('Hello how are you',style: TextStyle(color: Colors.grey, fontSize: 13)),
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 40,
            ),
            trailing: Column(
              children: [
                Text('11:55 PM',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                CircleAvatar(
                  radius: 14,
                  child: Text(
                    '352',
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(),
        Container(
          child: ListTile(
            title: Text('Veronica'),
            subtitle: Text('you: I Love you',style: TextStyle(color: Colors.grey, fontSize: 13)),
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 40,
            ),
            trailing: Column(
              children: [
                Text('11:55 PM',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                CircleAvatar(
                  radius: 14,
                  child: Text(
                    '352',
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(),
      ],
    ));
  }
}
