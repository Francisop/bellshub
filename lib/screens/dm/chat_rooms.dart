import 'package:bellshub/screens/dm/conversation.dart';
import 'dart:async';
import 'package:bellshub/screens/group/group_rooms.dart';
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
  Stream read;

  iniateSearch() {
    setState(() {
      isLoading = true;
    });
    databaseService.getUserByUsername(_searchController.text).then((val) {
      print(val.docs.toString());
      setState(() {
        searchSnapshot = val;
      });
      // Navigator.push(context,MaterialPageRoute(builder: (_) => SearchResultBottomSheet(searchSnapshot)));
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
                    color: Colors.pink
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.pink,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.text = '';
                                });
                                iniateSearch();
                                Timer timer =
                                    Timer(new Duration(seconds: 5), () {
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
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                                controller: _searchController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(height: 1.0),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.indigo.shade50)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.indigo.shade50)),
                                    hintText: 'Search...',
                                    fillColor: Colors.grey.shade100,
                                    filled: true)),
                          ),  
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => GroupRooms()));
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
          return SearchResultBottomSheet(searchSnapshot);
        });
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
                    roomId: snapshot.data.docs[i].get('chatroomId'),
                  );
                  // read: snapshot.data.docs[i].get('chatroomId'));
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
}

class ChatRoomsTile extends StatefulWidget {
  final String userName;
  final String roomId;
  ChatRoomsTile({this.userName, this.roomId});

  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  DatabaseService databaseService = DatabaseService();
  Stream read;
  Stream lastChat;

  checkRead() async {
    try {
      Constants.myMatric =
          await SharedPrefrenceUtils.getUserMatricSharedPreference();
      read = await databaseService.getUnreadConversations(
          widget.roomId, Constants.myMatric);
    } catch (e) {
      print('check read error $e');
    }

    // for (var data in read.data.docs) {
    //   print('this is the datas count');
    //   print(data.length);    }
  }

  getLastChat() {
    databaseService.getLastMessageSent(widget.roomId).then((val) {
      setState(() {
        lastChat = val;
      });
    });
  }

  @override
  void initState() {
    // getLastChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.userName != ""
        ? Container(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Conversation(
                            chatRoomId: widget.roomId, name: widget.userName)));
              },
              title: Text(
                widget.userName,
                style: simpleTextStyle(),
              ),
              subtitle: StreamBuilder(
                  stream: databaseService.getLastMessageSent(widget.roomId),
                  builder: (context, snapshot) {
                    return (snapshot.data != null)
                        ? Text(
                            (snapshot.data.docs[0].get('sendby') ==
                                    Constants.myMatric)
                                ? 'you: ${snapshot.data.docs[0].get('message')}'
                                : '${snapshot.data.docs[0].get('message')}',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox.shrink();
                  }),
              trailing: SizedBox(
                height: 30,
                width: 30,
                child: StreamBuilder(
                    stream: databaseService.getUnreadConversations(
                        widget.roomId, Constants.myMatric),
                    builder: (_, snapshot) {
                      if (snapshot.data == null) return Container();
                      return (snapshot.data != null &&
                              snapshot.data.docs.length > 0)
                          ? CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.indigo.shade200,
                              child: Text("${snapshot.data.docs.length}"))
                          : Container();
                    }),
              ),
              leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo.shade900,
                  child: Text(
                    widget.userName.substring(0, 1).toUpperCase(),
                    style: mediumTextStyle(),
                  )),
            ),
          )
        : Center(
            child: Text("No Chats yet",
                style: TextStyle(color: Colors.grey.shade300)));
  }
}

class SearchResultBottomSheet extends StatefulWidget {
  final QuerySnapshot searchSnapshot;
  SearchResultBottomSheet(this.searchSnapshot);
  @override
  _SearchResultBottomSheetState createState() =>
      _SearchResultBottomSheetState();
}

class _SearchResultBottomSheetState extends State<SearchResultBottomSheet> {
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
    return (widget.searchSnapshot.docs != [])
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
    if (userMatric == Constants.myMatric) {
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
