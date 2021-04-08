import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SchoolInfo extends StatefulWidget {
  final CarouselController remote;
  SchoolInfo({this.remote});

  @override
  _SchoolInfoState createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  final _matricNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot userId;
  var _selectedDepartment;
  var _selectedLevel;
  bool _isLoading = false;

  initMethod() async {
    Constants.myEmail =
        await SharedPrefrenceUtils.getUserEmailSharedPreference();
    databaseService.getUserByUserEmail(Constants.myEmail).then((e) {
      userId = e;
      // userId = userId.docs[0].id;
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 22, right: 22, bottom: 12, top: 4),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Container(
              color: Colors.white,
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: Text(
                  'Setup Account 🛠',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'We need some more information to setup your account',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
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
                    return 'Invalid matric formart e.g (0000/0000)';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'e.g 2000/3450',
                    labelText: 'Matric Number',
                    labelStyle: TextStyle(color: Colors.grey.shade400)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 62,
              margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new DropdownButton<String>(
                    value: _selectedLevel,
                    hint: Text('Select your level'),
                    items: Constants.levelDropdownValues
                        .map<DropdownMenuItem<String>>(
                            (String val) => DropdownMenuItem<String>(
                                  child: Text(val),
                                  value: val,
                                ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        _selectedLevel = value;
                      });
                    },
                    isExpanded: false,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 62,
              margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new DropdownButton<String>(
                    value: _selectedDepartment,
                    hint: Text('Department'),
                    items: Constants.departmentDropdownValues
                        .map<DropdownMenuItem<String>>(
                            (String val) => DropdownMenuItem<String>(
                                  child: Text(val),
                                  value: val,
                                ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        _selectedDepartment = value;
                      });
                    },
                    isExpanded: false,
                    // value: _dropdownValues.first,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.indigo.shade900,
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 55,
                child: TextButton.icon(
                  onPressed: () async {
                    if (_selectedLevel == null || _selectedDepartment == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.indigo[900],
                        content: Text(
                          'you forget to fill out a field 😅',
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    } else {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        Map<String, dynamic> userMap = {
                          'matric': _matricNoController.text,
                          'department':
                              _selectedDepartment.toString().toLowerCase(),
                          'level': _selectedLevel.toString().toLowerCase(),
                          'setup': true,
                        };
                        databaseService.updateUserInfo(
                            userId.docs[0].id, userMap);
                        await SharedPrefrenceUtils
                            .saveUserMatricSharedPreference(
                                _matricNoController.text);
                        await SharedPrefrenceUtils.saveSetupSharedPreference(
                            true);

                        ////////////////////////////////////////
                        FocusScope.of(context).requestFocus(FocusNode());
                        //////////////////////////////////

                        setState(() {
                          _isLoading = false;
                        });
                        widget.remote.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeIn);
                      }
                    }
                  },
                  icon: Icon(
                    Icons.arrow_right_alt,
                  ),
                  label: _isLoading == false
                      ? Text('Next')
                      : CircularProgressIndicator(
                          backgroundColor: Colors.white),
                )),
            SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
