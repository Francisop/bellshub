import 'package:bellshub/screens/dm/conversation.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'group_conversation.dart';

class GroupRooms extends StatefulWidget {
  @override
  _GroupRoomsState createState() => _GroupRoomsState();
}

class _GroupRoomsState extends State<GroupRooms> {
  DatabaseService databaseService = DatabaseService();
  Stream permanentGroups;

  initMethod() {
    databaseService.getPermanentGroups().then((value) {
      setState(() {
        permanentGroups = value;
      });
    });
  }

  @override
  void initState() {
    // initMethod();
    // TODO: implement initState
    super.initState();
  }

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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Group-chats',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  'Everything group chats both personal and concerning bells',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            )),

        ////////////////////////////////////
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('q8gt6W4J7FOnihhE4bU7')
                .collection('groups')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              if (snapshot.data == []) return Container();
              return Flexible(
                child: ListView.separated(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, int i) {
                    return ListTile(
                      title: Text('${snapshot.data.docs[i].get('name')}'),
                      subtitle: Text('last message sent in group'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 30,
                        child: Icon(
                          Icons.group,
                          size: 30,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GroupConversation(
                                    '${snapshot.data.docs[i].id}',
                                    '${snapshot.data.docs[i].get('name')}')));
                      },
                      trailing: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade300,
                        child: Text('123'),
                      ),
                    );
                    // Container(
                    //   child: Text('${snapshot.data.docs[i].get('name')}'),
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),

                // ListView(children: [
                //   ListTile(
                //     onTap: () {
                //       // Navigator.push(
                //       //     context, MaterialPageRoute(builder: (_) => Converstion()));
                //     },
                //     title: Text('Public Wall'),
                //     subtitle: Text(
                //       'Tope: Hello francis hoow are you today, my love i cant wait to see you',
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //     leading: CircleAvatar(
                //       backgroundColor: Colors.indigo,
                //       radius: 30,
                //       child: Icon(
                //         Icons.group,
                //         size: 30,
                //       ),
                //     ),
                //     trailing: CircleAvatar(
                //       radius: 16,
                //       backgroundColor: Colors.grey.shade300,
                //       child: Text('123'),
                //     ),
                //   ),
                //   Divider(),
                //   ListTile(
                //     onTap: () {
                //       // Navigator.push(
                //       //     context, MaterialPageRoute(builder: (_) => Converstion()));
                //     },
                //     title: Text('College Of Engineering'),
                //     subtitle: Text(
                //       'Tope: Hello francis hoow are you today, my love i cant wait to see you',
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //     leading: CircleAvatar(
                //       backgroundColor: Colors.indigo,
                //       radius: 30,
                //       child: Icon(
                //         Icons.group,
                //         size: 30,
                //       ),
                //     ),
                //     trailing: CircleAvatar(
                //       radius: 16,
                //       backgroundColor: Colors.grey.shade300,
                //       child: Text('123'),
                //     ),
                //   ),
                //   Divider(),
                // ]),
              );
            }),
        ///////////////////////////
      ])),
    );
  }
}
