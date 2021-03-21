import 'package:bellshub/services/database_service.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget {
  final CarouselController remote;
  GroupInfo(this.remote);
  @override
  _GroupInfoState createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  final _formKey = GlobalKey<FormState>();
  bool male = true;
  bool _loading = false;
  DatabaseService databaseService = DatabaseService();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // padding: EdgeInsets.only(left:20,right: 20,bottom: 20),
      child: Form(
        key: _formKey,
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            child: TextFormField(
              controller: _fullNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Group name cannot be empty';
                } else {
                  _formKey.currentState.save();
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
                  labelText: 'Group Name',
                  labelStyle: TextStyle(color: Colors.grey.shade400)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 14, right: 14),
            child: TextFormField(
              maxLines: 8,
              // style: TextStyle(height: 30),
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Group Description(optional)',
                  labelStyle: TextStyle(color: Colors.grey.shade400)),
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
                    // Map<String, dynamic> groupMap = {
                    //   'name': _fullNameController.text,
                    //   'description': _emailController.text,
                    //   'approved': false,
                    //   'users': _matricNoController.text,
                    //   'date_created': DateTime.now().millisecondsSinceEpoch,
                    //   'gender': (male == true) ? 'Male' : 'Female',
                    // };

                    //SharedPreference
                    //  databaseService.uploadUserInfo(userMap);
                    // await SharedPrefrenceUtils
                    //     .saveUserEmailSharedPreference(
                    //         _emailController.text);
                    // await SharedPrefrenceUtils
                    //     .saveUserLoggedInSharedPreference(true);
                    // await SharedPrefrenceUtils.saveUserNameSharedPreference(
                    //     _fullNameController.text);
                    // await SharedPrefrenceUtils
                    //     .saveUserMatricSharedPreference(
                    //         _matricNoController.text);
                    //////////////////////////////////

                    widget.remote.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                    setState(() {
                      _loading = false;
                    });
                  }
                },
                icon: Icon(
                  Icons.group,
                ),
                label: (_loading == true)
                    ? Text('Creating ...')
                    : Text('Create Group'),
              )),
          SizedBox(
            height: 50,
          ),
        ]),
      ),
    ));
  }
}
