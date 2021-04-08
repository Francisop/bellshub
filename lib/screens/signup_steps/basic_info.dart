import 'package:bellshub/services/auth_service.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/errors.dart';
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
  List<bool> _genderSelection = [true, false];
  bool _isLoading = false;
  bool _isMale = true;
  DatabaseService databaseService = DatabaseService();
  AuthService authService = AuthService();
  var res;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.amber,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_sharp,
                      color: Colors.black,
                    ),
                    label: Text(
                      'login',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ),
          ],
          // title: Text(
          //   'BellsHub',
          //   style: TextStyle(color: Colors.indigo.shade900),
          // ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                color: Colors.white,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // subtitle: Text(
                //   'Create a free account and join the new social norm',
                //   style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                // ),
              ),
              Center(
                child: Text(
                  'Create a free account and join the new social norm',
                  style: TextStyle(
                      color: Colors.indigo.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: TextFormField(
                  controller: _fullNameController,
                  validator: (value) {
                    if (value.trimRight().contains(" ") && value.length >= 4) {
                      _formKey.currentState.save();
                    } else {
                      return 'Invalid full name formart';
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
                        .hasMatch(value.trim())) {
                      _formKey.currentState.save();
                    } else {
                      return 'Invalid Email formart';
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  obscuringCharacter: '*',
                  controller: _passwordController,
                  validator: (value) {
                    if (RegExp(
                            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})")
                        .hasMatch(value)) {
                      _formKey.currentState.save();
                    } else {
                      return 'Password is weak';
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
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey.shade400)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
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
                      Container(
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(20),

                          disabledColor: Colors.black,
                          // selectedColor: Colors.white,
                          fillColor: Colors.amber,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Male',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Female',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                          isSelected: _genderSelection,
                          onPressed: (int i) {
                            if (i == 0) {
                              setState(() {
                                _genderSelection[i] = !_genderSelection[i];
                                _isMale = true;
                              });
                              _genderSelection[1] = false;
                            } else {
                              setState(() {
                                _genderSelection[i] = !_genderSelection[i];
                                _isMale = false;
                              });
                              _genderSelection[0] = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
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
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        
                        await authService.signUpWithEmailAndPassword(
                            _emailController.text.toLowerCase().trimRight(),
                            _passwordController.text);

                        var nameArray = _fullNameController.text.split(" ");
                        Map<String, dynamic> userMap = {
                          'fullname': _fullNameController.text
                              .toLowerCase()
                              .trimRight(),
                          'email': _emailController.text.toLowerCase(),
                          'matric': '',
                          'level': '',
                          'department': '',
                          'date_created': DateTime.now().millisecondsSinceEpoch,
                          'gender': (_isMale == false) ? 'female' : 'male',
                          'studentidimageurl': '',
                          'search_index': [
                            nameArray[0].toUpperCase(),
                            nameArray[1].toUpperCase()
                          ]
                        };

                        await databaseService.uploadUserInfo(userMap);
                        await SharedPrefrenceUtils
                            .saveCreatedAccountSharedPreference(true);
                        await SharedPrefrenceUtils.saveSetupSharedPreference(
                            false);
                        await SharedPrefrenceUtils
                            .saveUploadedIdSharedPreference(false);

                        await SharedPrefrenceUtils
                            .saveUserEmailSharedPreference(
                                _emailController.text);

                        await SharedPrefrenceUtils.saveUserNameSharedPreference(
                            _fullNameController.text);

                        ////////////////////////////////////////
                        FocusScope.of(context).requestFocus(FocusNode());
                        //////////////////////////////////

                        setState(() {
                          _isLoading = false;
                        });
                      }
                      widget.remote.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeIn);
                    },
                    icon: Icon(
                      Icons.arrow_right_alt,
                    ),
                    label: _isLoading == false
                        ? Text('Next')
                        : CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                  )),
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ));
  }
}
