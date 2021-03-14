import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:flutter/material.dart';

enum DT { harder, smarter, selfStarter, tradingCharter }

class Conversation extends StatefulWidget {
  var chatRoomId;
  var name;
  Conversation({this.chatRoomId, this.name});
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  var _selection;
  final _messageController = TextEditingController();
  Stream chatMessageStream;
  DatabaseService databaseService = new DatabaseService();

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (_, snapshot) {
          if (snapshot.data == null) return Container();
          return SizedBox(
            height: 300,
            child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, i) {
                  return MessageTile(
                    message: snapshot.data.docs[i].get('message'),
                    isSendByMe: snapshot.data.docs[i].get('sendby') ==
                        Constants.myMatric,
                  );
                }),
          );
        });
  }

  sendMessage() {
    if (_messageController.text != "") {
      Map<String, dynamic> messageMap = {
        'message': _messageController.text,
        "sendby": Constants.myMatric,
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
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.name}',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey.shade600,
        ),
        actions: [
          CircleAvatar(
            child: Icon(Icons.tv),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        child: Column(children: [
          Container(
            height: 600,
            // width: MediaQuery.of(context).size.width,
            child: chatMessageList(),
            // padding: EdgeInsets.only(bottom: 50),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade50,
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
                              color: Colors.amber),
                          child: TextField(
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
                            child: IconButton(
                                icon: Icon(Icons.send_rounded),
                                onPressed: () {
                                  sendMessage();
                                })),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PopupMenuButton<DT>(
                            onSelected: (DT result) {
                              setState(() {
                                _selection = result;
                              });
                              print(_selection);
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<DT>>[
                              const PopupMenuItem<DT>(
                                value: DT.harder,
                                child: Text('send an image'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.smarter,
                                child: Text('Being a lot smarter'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.selfStarter,
                                child: Text('Being a self-starter'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.tradingCharter,
                                child:
                                    Text('Placed in charge of trading charter'),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile({this.message, this.isSendByMe});
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Color(0xff007EF4), Color(0xff2A75BC)]
                    : [Color(0x1AFFFFFF), Color(0x1AFFFFFF)]),
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
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
      ),
    );
  }
}
