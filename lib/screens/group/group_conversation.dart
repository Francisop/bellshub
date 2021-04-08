import 'dart:async';
import 'dart:math';

import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupConversation extends StatefulWidget {
  final String name;
  final String groupRoomId;

  GroupConversation(this.groupRoomId, this.name);
  @override
  _GroupConversationState createState() => _GroupConversationState();
}

class _GroupConversationState extends State<GroupConversation> {
  final _messageController = TextEditingController();
  Stream chatMessageStream;
  DatabaseService databaseService = DatabaseService();
  ScrollController _scrollController = new ScrollController();
  var value;
 
  initMethod() async {
    Constants.myMatric =
        await SharedPrefrenceUtils.getUserMatricSharedPreference();
    Constants.myName = await SharedPrefrenceUtils.getUserNameSharedPreference();
    await databaseService
        .getGroupConversationMessages(widget.groupRoomId)
        .then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });

    int i = 0;
    await databaseService
        .getUnreadGroupConversations(widget.groupRoomId, Constants.myMatric)
        .forEach((e) {
      for (i = 0; i < e.docs.length; i++) {
        // print();
        databaseService.setGroupReadConversation(
            widget.groupRoomId, e.docs[i].id);
      }
    });
  }

  Color randomColorPicker() {
    List<Color> randomColors = [
      Colors.red[900],
      Colors.blue[900],
      Colors.grey[900],
      Colors.green[900],
      Colors.purple[900]
    ];
    final _random = new Random();
    var element = randomColors[_random.nextInt(randomColors.length)];
    return element;
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo[900],
        title: Text(
          '${widget.name}',
          style: TextStyle(color: Colors.white, fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CircleAvatar(
              backgroundColor: Colors.indigo.shade400,
              child: Icon(Icons.group)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          child: Stack(children: [
            Container(
              height: 600,
              // width: MediaQuery.of(context).size.width,
              child: chatMessageList(),
              // padding: EdgeInsets.only(bottom: 50),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: IntrinsicHeight(
                        child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: TextField(
                            onTap: () {
                              Timer(
                                  Duration(milliseconds: 300),
                                  () => _scrollController.jumpTo(
                                      _scrollController
                                          .position.maxScrollExtent));
                            },
                            controller: _messageController,
                            style: TextStyle(fontSize: 15.0, height: 1.0),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Message...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.indigo.shade800,
                            child: IconButton(
                                icon: Icon(Icons.send_rounded),
                                onPressed: () {
                                  sendMessage();
                                })),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.indigo.shade800,
                            child: IconButton(
                                icon: Icon(Icons.attach_file_outlined),
                                onPressed: () {
                                  showSendables();
                                })),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

/////////////
  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (_, snapshot) {
          if (snapshot.data == null) return Container();
          return SizedBox(
            height: 500,
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 100),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, i) {
                  return MessageTile(
                      message: snapshot.data.docs[i].get('message'),
                      isSendByMe: snapshot.data.docs[i].get('sendby') ==
                          Constants.myMatric,
                      username: snapshot.data.docs[i].get('username'),
                      color: randomColorPicker());
                }),
          );
        });
  }

  sendMessage() {
    print(Constants.myName);
    if (_messageController.text.trim() != "") {
      Map<String, dynamic> messageMap = {
        'message': _messageController.text.trim(),
        "sendby": Constants.myMatric,
        "read": false,
        "username": Constants.myName,
        'color': '${randomColorPicker()}',
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseService.addGroupConversationMessages(
          widget.groupRoomId, messageMap);
      setState(() {
        _messageController..text = "";
      });
      Timer(
          Duration(milliseconds: 300),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }

  showSendables() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (context) {
          return Container(
            height: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: CircleAvatar(
                          radius: 30,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.fileArchive),
                            onPressed: () {},
                          ))),
                  Container(
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.camera),
                            onPressed: () {},
                          ))),
                  Container(
                      child: CircleAvatar(
                          radius: 30,
                          child: IconButton(
                            icon: Icon(Icons.tv),
                            onPressed: () {},
                          ))),
                ]),
          );
        });
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  final String username;
  final Color color;
  MessageTile({this.message, this.isSendByMe, this.username, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      padding: EdgeInsets.only(
        left: isSendByMe ? 0 : 24,
        right: isSendByMe ? 24 : 0,
      ),
      // width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.indigo.shade900, Colors.indigo.shade900]
                    : [Colors.white, Colors.white]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Column(
          crossAxisAlignment:
              (isSendByMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            (isSendByMe)
                ? SizedBox.shrink()
                : Text(
                    username,
                    style: TextStyle(color: color, fontSize: 13),
                  ),
            SizedBox(
              height: 3,
            ),
            Text(
              message,
              style: TextStyle(
                  color: (isSendByMe) ? Colors.white : Colors.black,
                  fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }
}
