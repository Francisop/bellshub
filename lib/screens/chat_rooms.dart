import 'dart:async';

import 'package:bellshub/screens/conversation.dart';
import 'package:bellshub/screens/groups.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:bellshub/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  DatabaseService databaseService = DatabaseService();
  final _searchController = TextEditingController();
  QuerySnapshot searchSnapshot;
  bool isLoading = false;
  Stream chatRoomsStream;

  iniateSearch() {
    setState(() {
      isLoading = true;
    });
    databaseService.getUserByUsername(_searchController.text).then((val) {
      print(val.docs.toString());
      setState(() {
        searchSnapshot = val;
      });
      // Navigator.push(context,MaterialPageRoute(builder: (_) => MyBottomSheet(searchSnapshot)));
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.amber[900],
                  ),
                  onPressed: () {},
                ),
              )
            ],
            backgroundColor: Colors.white,
            title: Padding(
              // padding: const EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
              padding: const EdgeInsets.all(12),
              child: Text('BellsHub',
                  style: TextStyle(fontSize: 20, color: Colors.black87)),
            ),
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                // padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.text = '';
                          });
                          iniateSearch();
                          Timer timer = Timer(new Duration(seconds: 5), () {
                            setState(() {
                              isLoading = false;
                            });
                            searcchResult();
                          });
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      height: 70.0,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(height: 1.0),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.indigo.shade50)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.indigo.shade50)),
                              hintText: 'Search...',
                              fillColor: Colors.grey.shade100,
                              filled: true)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Groups()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.indigo,
                          ),
                          child: Text('Groups',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: isLoading == false
            ? SafeArea(
                child: Container(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    chatRoomList(),
                  ]),
                ),
              )
            : Center(
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.indigo,
                    strokeWidth: 3.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Searching ... ')
                ]),
              ));
  }

  void searcchResult() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MyBottomSheet(searchSnapshot);
        });
  }

  createChatRoomAndStartConversation(String userMatric) {
    if (userMatric != Constants.myMatric) {
      print("this is constant name ${Constants.myMatric}");
      String chatRoomId = getChatRoomId(userMatric, Constants.myMatric);
      List<String> users = [userMatric, Constants.myMatric];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      databaseService.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Conversation(chatRoomId: chatRoomId)));
    } else {
      print("scaffold aint working");
      SnackBar(
        backgroundColor: Colors.white,
        content: Text("hello"),
      );
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return searchTile(
                searchSnapshot.docs[i].get('name'),
                searchSnapshot.docs[i].get('email'),
                searchSnapshot.docs[i].get('matric'),
              );
            },
          )
        : Center(
            child: Container(
              child: Text('No such user exists'),
            ),
          );
  }

  Widget searchTile(String userName, String userEmail, String userMatric) {
    print(userName);
    return ListTile(
      leading: CircleAvatar(
          radius: 30,
          child: Icon(
            FontAwesomeIcons.user,
            size: 30,
          )),
      title: Text(
        userName,
        style: TextStyle(color: Colors.black),
      ),
      trailing: MaterialButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.pop(context);
          createChatRoomAndStartConversation(userMatric);
        },
        child: Text('message'),
      ),
    );
  }

  // Concerning the chat rooms
  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (_, snapshot) {
          if (snapshot.data == [])
            return Center(
                child: Container(
                    child: Text('No Chat rooms yet',
                        style: TextStyle(color: Colors.grey.shade500))));
          if (snapshot.data == null)
            return Center(
                child: Container(
                    child: Text('No Chat rooms yet',
                        style: TextStyle(color: Colors.grey.shade500))));
          return Flexible(
            child: ListView.separated(
                itemCount: snapshot.data.docs.length,
                separatorBuilder: (context, int i) {
                  return Divider();
                },
                itemBuilder: (context, int i) {
                  var name = snapshot.data.docs[i]
                      .get('chatroomId')
                      .toString()
                      .split('_');
                  return ChatRoomsTile(
                      userName: name[0],
                      roomId: snapshot.data.docs[i].get('chatroomId'));
                }),
          );
        });
  }

  getUserInfo() async {
    Constants.myMatric =
        await SharedPrefrenceUtils.getUserMatricSharedPreference();
    databaseService.getChatRooms(Constants.myMatric).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
  }

  getChatRoomId(String a, b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String roomId;
  ChatRoomsTile({this.userName, this.roomId});
  @override
  Widget build(BuildContext context) {
    return userName != ""
        ? Container(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            Conversation(chatRoomId: roomId, name: userName)));
              },
              title: Text(
                userName,
                style: simpleTextStyle(),
              ),
              leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xff007EF4),
                  child: Text(
                    userName.substring(0, 1).toUpperCase(),
                    style: mediumTextStyle(),
                  )),
            ),
          )
        : Center(
            child: Text("No Chas yet", style: TextStyle(color: Colors.indigo)));
  }
}

class MyBottomSheet extends StatefulWidget {
  var searchSnapshot;
  MyBottomSheet(this.searchSnapshot);
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  DatabaseService databaseService = DatabaseService();

  initMethod() async {
    Constants.myName = await SharedPrefrenceUtils.getUserNameSharedPreference();
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.searchSnapshot.docs);
    return widget.searchSnapshot != []
        ? Container(
            height: 999,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            // decoration:,
            child: ListView.builder(
                itemCount: widget.searchSnapshot.docs.length,
                // shrinkWrap: false,
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(17),
                    leading: CircleAvatar(
                        radius: 30,
                        child: Icon(
                          FontAwesomeIcons.user,
                          size: 30,
                        )),
                    // title: Text(
                    //   'what a load',
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    title: Text(
                      '${widget.searchSnapshot.docs[i].get('fullname')}',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                        createChatRoomAndStartConversation(
                            '${widget.searchSnapshot.docs[i].get('matric')}',
                            '${widget.searchSnapshot.docs[i].get('fullname')}');
                      },
                      child: Text('message'),
                    ),
                  );
                }),
          )
        : widget.searchSnapshot == null
            ? Center(
                child: Container(
                  child: Text('No such user exists'),
                ),
              )
            : Center(
                child: Container(
                  child: Text('No such user exists'),
                ),
              );
  }

  createChatRoomAndStartConversation(String userMatric, String fullname) {
    if (userMatric != Constants.myMatric) {
      print("this is constant name ${Constants.myMatric}");
      String chatRoomId = getChatRoomId(fullname, Constants.myName);
      List<String> users = [userMatric, Constants.myMatric];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      databaseService.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  Conversation(chatRoomId: chatRoomId, name: fullname)));
    } else {
      print("scaffold aint working");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('this is your chat'),
        ),
      );
    }
  }

  getChatRoomId(String a, b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
