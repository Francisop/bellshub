import 'package:bellshub/screens/group/create_groups.dart/create_group.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
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

  initMethod() async {
    Constants.myMatric =
        await SharedPrefrenceUtils.getUserMatricSharedPreference();
  }

  @override
  void initState() {
    initMethod();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateGroup()));
        },
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
                      subtitle: StreamBuilder(
                          stream: databaseService.getLastGroupMessageSent(
                              snapshot.data.docs[i].id),
                          builder: (context, snapshotAsync) {
                            if (snapshotAsync.data == null) return Container();
                            return Text(
                              '${snapshotAsync.data.docs[0].get('username')}' +
                                  ': ${snapshotAsync.data.docs[0].get('message')}',
                              style: TextStyle(),
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
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
                      trailing: SizedBox(
                        height: 30,
                        width: 30,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc('q8gt6W4J7FOnihhE4bU7')
                                .collection('groups')
                                .doc(snapshot.data.docs[i].id)
                                .collection('chats')
                                .where('sendby',
                                    isNotEqualTo: Constants.myMatric)
                                .where('read', isEqualTo: false)
                                .snapshots(),
                            builder: (context, snapshotBsync) {
                              if (snapshotBsync.data == null)
                                return SizedBox.shrink();
                              if (snapshotBsync.data.docs.length == 0)
                                return SizedBox.shrink();
                              return CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey.shade300,
                                child:
                                    Text('${snapshotBsync.data.docs.length}'),
                              );
                            }),
                      ),
                    );
                    // Container(
                    //   child: Text('${snapshot.data.docs[i].get('name')}'),
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(),
                    );
                  },
                ),
              );
            }),
        ///////////////////////////
      ])),
    );
  }
}
