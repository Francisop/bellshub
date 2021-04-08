import 'dart:async';
import 'dart:io';

import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'image_preview.dart';

class Conversation extends StatefulWidget {
  var chatRoomId;
  var name;
  Conversation({this.chatRoomId, this.name});
  @override
  _ConversationState createState() => _ConversationState();
}

Route _transitionRoute(location) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => location,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 0.1);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

class _ConversationState extends State<Conversation> {
  bool _crossSendable = false;
  final _messageController = TextEditingController();
  Stream chatMessageStream;
  DatabaseService databaseService = new DatabaseService();
  ScrollController _scrollController = new ScrollController();
  File file;
  PickedFile _imageFile;
  final _picker = ImagePicker();

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
                    imageCaption: snapshot.data.docs[i].get('image_caption'),
                    imageUrl: snapshot.data.docs[i].get('message_image'),
                    type: snapshot.data.docs[i].get('type'),
                    message: snapshot.data.docs[i].get('message'),
                    isSendByMe: snapshot.data.docs[i].get('sendby') ==
                        Constants.myMatric,
                  );
                }),
          );
        });
  }

  sendMessage() {
    Timer(
        Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));

    if (_messageController.text.trim() != "") {
      Map<String, dynamic> messageMap = {
        'type': 'chat',
        'message': _messageController.text.trim(),
        "sendby": Constants.myMatric,
        "read": false,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseService.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        _messageController..text = "";
      });
    }
  }

  initMethod() async {
    Constants.myMatric =
        await SharedPrefrenceUtils.getUserMatricSharedPreference();
    databaseService.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    databaseService
        .getUnreadConversations(widget.chatRoomId, Constants.myMatric)
        .then((val) {
      print(val.data.docs);
    });

    int i = 0;
    await databaseService
        .getUnreadConversations(widget.chatRoomId, Constants.myMatric)
        .forEach((e) {
      for (i = 0; i < e.docs.length; i++) {
        databaseService.setReadConversation(widget.chatRoomId, e.docs[i].id);
      }
    });
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
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
            child: Icon(FontAwesomeIcons.user),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        child: Stack(children: [
          Container(
            height: 600,
            // width: MediaQuery.of(context).size.width,
            child: chatMessageList(),
            // padding: EdgeInsets.only(bottom: 50),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: _crossSendable
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              secondChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                height: 155,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _crossSendable = false;
                            });
                          },
                          label: Text(
                            '',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          icon:
                              Icon(Icons.cancel_outlined, color: Colors.black),
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.blueGrey.shade900,
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.fileArchive),
                                    onPressed: () {
                                      setState(() {
                                        _crossSendable = false;
                                      });
                                      // _pickFile();
                                    },
                                  )),
                              Text(
                                'Document',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          )),
                          Container(
                              child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.red.shade900,
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.photoVideo,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _crossSendable = false;
                                      });
                                      _pickImage();
                                    },
                                  )),
                              Text(
                                'Gallery',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          )),
                          Container(
                              child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.indigo.shade900,
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(Icons.person_pin_circle),
                                    onPressed: () {
                                      setState(() {
                                        _crossSendable = false;
                                      });
                                    },
                                  )),
                              Text(
                                'Contact',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          )),
                        ]),
                  ],
                ),
              ),
              firstChild: Container(
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
                                  if (WidgetsBinding
                                          .instance.window.viewInsets.bottom >
                                      0.0) {
                                    setState(() {
                                      _crossSendable = true;
                                    });
                                  } else {
                                    showSendables();
                                  }
                                })),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  _pickImage() async {
    _imageFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(_imageFile.path);
    });
    if (file != null) {
      Navigator.of(context)
          .push(_transitionRoute(ImagePreview(file, widget.chatRoomId)));
    }
  }

  // _pickFile() async {
  //   final path = await FlutterDocumentPicker.openDocument();

  //   if (path != null) {
  //     print(path.toString());
  //     print(path.characters);
  //     print(path.length);
  //     print(path.runtimeType);
  //     print(path);
  //   } else {
  //     // User canceled the picker
  //   }
  // }

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
            height: 120,
            padding: EdgeInsets.all(12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade900,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.fileArchive),
                            onPressed: () {
                              // _pickFile();
                            },
                          )),
                      Text(
                        'Document',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  )),
                  Container(
                      child: Column(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.red.shade900,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.photoVideo,
                                color: Colors.white),
                            onPressed: () {
                              _pickImage();
                            },
                          )),
                      Text(
                        'Gallery',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  )),
                  Container(
                      child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.indigo.shade900,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(Icons.person_pin_circle),
                            onPressed: () {},
                          )),
                      Text(
                        'Contact',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  )),
                ]),
          );
        });
  }
}
////////////////////////////////////////////////////////////////////////////////
///End of Conversattion
/////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
class MessageTile extends StatelessWidget {
  final String type;
  final String imageUrl;
  final String imageCaption;
  final String message;
  final bool isSendByMe;
  MessageTile(
      {this.message,
      this.isSendByMe,
      this.type,
      this.imageCaption,
      this.imageUrl});
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
      child: type == 'chat'
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
              child: Text(
                message,
                style: TextStyle(
                    color: isSendByMe ? Colors.white : Colors.indigo[900],
                    fontSize: 17.0),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: isSendByMe
                        ? [Colors.indigo.shade900, Colors.indigo.shade900]
                        : [Colors.white, Colors.white]),
              ),
              child: Column(children: [
                Image(image: NetworkImage(imageUrl)),
              ])),
    );
  }
}
