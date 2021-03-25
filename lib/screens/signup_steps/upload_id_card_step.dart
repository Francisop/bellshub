import 'dart:async';
import 'dart:io';

import 'package:bellshub/main.dart';
import 'package:bellshub/screens/home.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadIdCardStep extends StatefulWidget {
  @override
  _UploadIdCardStepState createState() => _UploadIdCardStepState();
}

class _UploadIdCardStepState extends State<UploadIdCardStep> {
  PickedFile _imageFile;
  final _picker = ImagePicker();
  DatabaseService databaseService = DatabaseService();
  DownloadTask downloadUrl;
  File file;
  QuerySnapshot uId;
  FirebaseStorage taskSnapshot;
  var userId;

  /// Select an image via gallery or camera
  _pickImage() async {
    _imageFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(_imageFile.path);
    });
    if (_imageFile != null) {
      downloadUrl = await databaseService.uploadIdCard(file);
      print(downloadUrl.snapshot);

      await SharedPrefrenceUtils.saveUserVerifiedSharedPreference('Awaiting');

      print('done');

      print(Constants.myEmail);

      await databaseService
          .getUserByUserEmail('francisohis@gmail.com')
          .then((e) {
        setState(() {
          uId = e;
          userId = uId.docs[0].id;
        });
        print(uId.docs[0].id);
      });
      // Timer(Duration(seconds: 5), () {
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No image uploaded'),
      ));
    }
  }

  /// Remove image
  void _clear() {
    setState(() {
      _imageFile = null;
      file = null;
    });
    // setState(() _imageFile = null);
  }

  initMethodd() async {
    Constants.myEmail =
        await SharedPrefrenceUtils.getUserEmailSharedPreference();
  }

  @override
  void initState() {
    initMethodd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                  ),
                  child: (file != null)
                      ? Center(
                          child: Image.file(
                            file,
                            width: MediaQuery.of(context).size.width * 0.8,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image(
                            width: MediaQuery.of(context).size.width * 0.8,
                            image: AssetImage('assets/img/default_id.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                  height: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo.shade100,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton.icon(
                    onPressed: () {
                      _pickImage();
                    },
                    icon: Icon(Icons.upload_rounded),
                    label: Text(
                      'Upload BellsTech ID card',
                      style: TextStyle(color: Colors.indigo[900]),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              (file != null)
                  ? Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo.shade100,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton.icon(
                        onPressed: () {
                          _clear();
                        },
                        icon: Icon(Icons.replay_circle_filled),
                        label: Text(
                          'Reset image',
                          style: TextStyle(color: Colors.indigo[900]),
                        ),
                      ))
                  : Container(),
              SizedBox(
                height: 20,
              ),
              (file != null)
                  ? Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo.shade100,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton.icon(
                        onPressed: () async {
                          await databaseService.updateIdCardUrl(
                              userId, downloadUrl);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Verification()));
                        },
                        icon: Icon(Icons.done),
                        label: Text(
                          'Done',
                          style: TextStyle(color: Colors.indigo[900]),
                        ),
                      ))
                  : Container(),
            ],
          )),
    ));
  }
}

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Awaiting Verification')),
      ),
    );
  }
}
