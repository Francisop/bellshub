import 'package:bellshub/services/auth_service.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  final CarouselController remote;
  BasicInfo(this.remote);
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final _formKey = GlobalKey<FormState>();
  bool male = true;
  bool _loading = false;
  DatabaseService databaseService = DatabaseService();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _matricNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'BellsHub',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo[900],
        ),
        backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.only(left:20,right: 20,bottom: 20),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                color: Colors.indigo[900],
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: TextFormField(
                  controller: _fullNameController,
                  validator: (value) {
                    if (value.contains(" ") && value.length >= 9) {
                      _formKey.currentState.save();
                    } else {
                      return 'Invalid full name formart';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Name should be same on id card',
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.grey.shade400)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      _formKey.currentState.save();
                    } else {
                      return 'Invalid Email formart';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'example@example.com',
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.grey.shade400)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: TextFormField(
                  controller: _matricNoController,
                  validator: (value) {
                    if (value.contains("/") && value.length == 9) {
                      _formKey.currentState.save();
                    } else {
                      return 'Invalid Matric No. formart';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'e.g 2000/3450',
                      labelText: 'Matric Number',
                      labelStyle: TextStyle(color: Colors.grey.shade400)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Gender',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            male = true;
                          });
                        },
                        child: Container(
                          child: Text(
                            'Male',
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          // width: 200,
                          padding: EdgeInsets.all(20),
                          color: (male == true) ? Colors.amber : Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            male = false;
                          });
                        },
                        child: Container(
                          child: Text(
                            'Female',
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          // width: 200,
                          padding: EdgeInsets.all(20),
                          color: (male != true) ? Colors.amber : Colors.white,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _loading = true;
                        });

                        //////////////////////////////////
                        Map<String, dynamic> userMap = {
                          'fullname': _fullNameController.text,
                          'email': _emailController.text,
                          'approved': false,
                          'matric': _matricNoController.text,
                          'date_created': DateTime.now().millisecondsSinceEpoch,
                          'gender': (male == true) ? 'Male' : 'Female',
                          'studentidimageurl': ''
                        };

                        //SharedPreference
                        databaseService.uploadUserInfo(userMap);
                        await SharedPrefrenceUtils
                            .saveUserEmailSharedPreference(
                                _emailController.text);
                        await SharedPrefrenceUtils
                            .saveUserLoggedInSharedPreference(true);
                        await SharedPrefrenceUtils.saveUserNameSharedPreference(
                            _fullNameController.text);
                        await SharedPrefrenceUtils
                            .saveUserMatricSharedPreference(
                                _matricNoController.text);
                        ////////////////////////////////////////
                        FocusScope.of(context).requestFocus(FocusNode());
                        //////////////////////////////////
                        widget.remote.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeIn);
                        // setState(() {
                        //   _loading = false;
                        // });
                      }
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                    ),
                    label:
                        (_loading == true) ? Text('Loading ...') : Text('Next'),
                  )),
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ));
  }
}
