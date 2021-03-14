import 'package:bellshub/screens/conversation.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo[600],
      ),
      body: Container(
          child: Column(children: [
        Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.indigo[600],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.arrow_back_ios) , color: Colors.white,onPressed: (){Navigator.pop(context);},),
                title: Text(
                  'Group-chats',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  'Everything group chats both personal and concerning bells',
                  style: TextStyle(color: Colors.white,fontSize: 13),
                ),
              ),
            )),
        Flexible(
          child: ListView(children: [
            ListTile(
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => Converstion()));
              },
              title: Text('Public Wall'),
              subtitle: Text(
                'Tope: Hello francis hoow are you today, my love i cant wait to see you',
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: 30,
                child: Icon(
                  Icons.group,
                 size: 30,
                ),
              ),
              trailing: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade300,
                child: Text('123'),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => Converstion()));
              },
              title: Text('College Of Engineering'),
              subtitle: Text(
                'Tope: Hello francis hoow are you today, my love i cant wait to see you',
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: 30,
                child: Icon(
                  Icons.group,
                  size: 30,
                ),
              ),
              trailing: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade300,
                child: Text('123'),
              ),
            ),
            Divider(),
          ]),
        )
      ])),
    );
  }
}
