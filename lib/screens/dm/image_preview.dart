import 'dart:async';
import 'dart:io';

import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatefulWidget {
  final File file;
  var chatRoomId;
  ImagePreview(this.file, this.chatRoomId);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  DatabaseService databaseService = DatabaseService();
  final _captionController = TextEditingController();
  bool _isLoading = false;

  initMethod() async {
    Constants.myMatric =
        await SharedPrefrenceUtils.getUserMatricSharedPreference();
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
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 250,
            child: PhotoView(
              imageProvider: FileImage(widget.file),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: TextFormField(
                    controller: _captionController,
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        suffixIcon: _isLoading == false
                            ? CircleAvatar(
                                radius: 27,
                                child: IconButton(
                                  icon: Icon(Icons.send_outlined,
                                      color: Colors.white, size: 27),
                                  onPressed: () {
                                    sendImageMessage();
                                  },
                                ))
                            : SizedBox(
                                height: 20, child: CircularProgressIndicator()),
                        border: InputBorder.none,
                        hintText: 'Add a Caption ..',
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 14))),
              ))
        ]),
      ),
    );
  }

  sendImageMessage() async {
    if (widget.file != null) {
      setState(() {
        _isLoading = true;
      }); 
// save to storage first
      await databaseService.uploadImage(widget.file).then((e) {
        e.ref.getDownloadURL().then((imageUrl) {
          Map<String, dynamic> messageMap = {
            'image_url': imageUrl,
            'message': _captionController.text.trim(),
            "sendby": Constants.myMatric,
            "read": false,
            "time": DateTime.now().millisecondsSinceEpoch
          };
          databaseService.addConversationMessages(
              widget.chatRoomId, messageMap);
        });
      });
      setState(() {
        _captionController..text = "";
      });
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }
}
