import 'dart:math';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  var barcode;
  DatabaseService databaseService = DatabaseService();
  Stream createdQrcodeData;
  QuerySnapshot userId;
  Stream receivedQrcodeData;

  initMethod() async {
    Constants.myEmail =
        await SharedPrefrenceUtils.getUserEmailSharedPreference();
    await databaseService.getUserByUserEmail(Constants.myEmail).then((val) {
      setState(() {
        userId = val;
      });
    });

    receivedQrcodeData =
        await databaseService.getReceivedQrcode(userId.docs[0].id);
    createdQrcodeData =
        await databaseService.getCreatedQrcode(userId.docs[0].id);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      checkScan(barcode);

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('$barcode'),
      // ));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  checkScan(qrCode) async {
    QuerySnapshot scan;
    await databaseService.checkScanned(userId.docs[0].id, qrCode).then((e) {
      setState(() {
        scan = e;
      });
    });

    if (scan.docs[0].get('assigned_to') != null) {
      if (scan.docs[0].get('scanned') == true) {
        print('already scanned');
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  insetPadding: EdgeInsets.only(
                      top: 200, bottom: 200, left: 15, right: 15),
                  child: Center(
                      child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.amber.shade400,
                                  radius: 50,
                                  child: Icon(
                                    Icons.warning_rounded,
                                    color: Colors.black,
                                    size: 100,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User has been scanned before!!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade600),
                              )
                            ],
                          ))),
                ));
      } else {
        print('update');
        await databaseService.updateScanned(userId.docs[0].id, scan.docs[0].id);
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  insetPadding: EdgeInsets.only(
                      top: 200, bottom: 200, left: 15, right: 15),
                  child: Center(
                      child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 50,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green.shade500,
                                    size: 100,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Successful',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade600),
                              )
                            ],
                          ))),
                ));
      }
    } else {
      print('not assigned');
    }
    // print(scan.docs[0].get('scanned'));
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CreateQrcode()));
          },
          backgroundColor: Colors.pink,
          label: Row(
            children: [Icon(Icons.edit), Text(' Create')],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade500,
          title: Text('QrCode'),
          actions: [
          TextButton.icon(
              onPressed: () {
                scan();
              },
              icon: Icon(Icons.qr_code_scanner,color: Colors.white), label: Text('Scan',style: TextStyle(color:Colors.white),),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.pink.shade900,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            tabs: [
              Text('Created'),
              Text('Received'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CreatedQrcode(createdQrcodeData),
            RevceivedQrcode(receivedQrcodeData)
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
class RevceivedQrcode extends StatefulWidget {
  Stream receivedQrcodeData;
  RevceivedQrcode(this.receivedQrcodeData);

  @override
  _RevceivedQrcodeState createState() => _RevceivedQrcodeState();
}

class _RevceivedQrcodeState extends State<RevceivedQrcode> {
  GlobalKey globalKey = new GlobalKey();

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Material Alert!'),
        content: Center(
            child: RepaintBoundary(
                // key: globalKey,
                child: QrImage(
          data: '1234567890',
          version: QrVersions.auto,
          size: 200.0,
        ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.receivedQrcodeData,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Text('No Received Qrcodes')));
          }
          if (!snapshot.hasData) {
            return Container(child: Center(child: Text('No Received Qrcodes')));
          }
          return ListView.separated(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (_, int i) {
              return ListTile(
                leading: Icon(Icons.arrow_right_alt),
                title: Text(
                  snapshot.data.docs[i].get('qrcode_name'),
                  style: TextStyle(fontSize: 20),
                ),
                // subtitle: Text(
                trailing: IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.only(
                                  top: 200, bottom: 200, left: 20, right: 20),
                              child: Center(
                                  child: RepaintBoundary(
                                      key: globalKey,
                                      child: QrImage(
                                        data: snapshot.data.docs[i]
                                            .get('qrcode_code'),
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ))),
                            ));
                    // Navigator.of(context).restorablePush(_dialogBuilder);
                    // _shareBottomSheet();
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        });
  }
}

////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////

class CreatedQrcode extends StatefulWidget {
  Stream createdQrcodeData;
  CreatedQrcode(this.createdQrcodeData);

  @override
  _CreatedQrcodeState createState() => _CreatedQrcodeState();
}

class _CreatedQrcodeState extends State<CreatedQrcode> {
  Stream createdQrcodeData;
// CreatedQrcode(this.createdQrcodeData);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.createdQrcodeData,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (_, int i) {
              return ListTile(
                leading: Icon(Icons.adjust_sharp),
                title: Text(
                  snapshot.data.docs[i].get('qrcode_name'),
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                    'expires on: ${snapshot.data.docs[i].get('date_expiry')}'),
                trailing: IconButton(
                  icon: Icon(Icons.share_outlined),
                  onPressed: () {
                    _shareBottomSheet();
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        });
  }

  void _shareBottomSheet() {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.amber,
        context: context,
        builder: (ctx) => Container(
              padding: EdgeInsets.all(12),
              width: 300,
              height: 250,
              color: Colors.white54,
              // alignment: Alignment.center,
              child: ListView(children: [
                ListTile(
                  onTap: () async {
                    await SharedPrefrenceUtils
                        .saveUserAnouncementSharedPreference(false);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Announcement Started')));
                  },
                  title: Text('Announce this link'),
                  leading: CircleAvatar(
                      radius: 30, child: Icon(Icons.announcement_rounded)),
                ),
                Divider(),
              ]),
            ));
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CreateQrcode extends StatefulWidget {
  @override
  _CreateQrcodeState createState() => _CreateQrcodeState();
}

class _CreateQrcodeState extends State<CreateQrcode> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();
  var _date;
  final _qrcodeNameController = TextEditingController();
  final _qrcodeAmountcontroller = TextEditingController();

  bool _isLoading = false;

  initMethod() async {
    Constants.myEmail =
        await SharedPrefrenceUtils.getUserEmailSharedPreference();
  }

  @override
  void initState() {
    initMethod();
    _qrcodeAmountcontroller..text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _qrcodeNameController.dispose();
    _qrcodeAmountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        title: Text('Create Qrcode'),
      ),
      body: _isLoading == false
          ? Container(
              child: Form(
              key: _formKey,
              child: ListView(children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: TextFormField(
                    controller: _qrcodeNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'QrCode name cannot be empty';
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
                        labelText: 'Qrcode label',
                        labelStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: TextFormField(
                    controller: _qrcodeAmountcontroller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      } else {
                        _formKey.currentState.save();
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'default is 1',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Number of qrcodes to generate',
                        labelStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: DateTimePicker(
                    // controller: _dateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Expiry Date',
                        labelStyle: TextStyle(color: Colors.grey.shade400)),
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    onChanged: (val) => print(val),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Expiry date is required';
                      } else {
                        _formKey.currentState.save();
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _date = val;
                      });
                      print(val);
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: EdgeInsets.only(left: 14, right: 14, bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          QuerySnapshot userId;
                          await databaseService
                              .getUserByUserEmail(Constants.myEmail)
                              .then((val) {
                            setState(() {
                              userId = val;
                            });
                            print(userId.docs[0].id);
                          });
                          int i = 0;
                          int value = int.parse(_qrcodeAmountcontroller.text);
                          for (i = 0; i < value; i++) {
                            Map<String, dynamic> qrcodeMap = {
                              'qrcode_name': _qrcodeNameController.text,
                              'qrcode_code': getRandomString(22),
                              'date_created': DateTime.now(),
                              'date_expiry': '$_date',
                              'type': 'created',
                              'assigned_to': null
                            };
                            await databaseService.createQrcode(
                                userId.docs[0].id, qrcodeMap);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.qr_code_sharp,
                        color: Colors.indigo.shade900,
                      ),
                      label: Text('Generate qrcode',
                          style: TextStyle(color: Colors.indigo[900])),
                    )),
              ]),
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

// Qrcode coode generator
  final _chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#^&*()_+|}{.sfsdfd886sdf8s8fysdf9ys8fysfsdfsdfhwuru90729 72394239euds.,.,,][/.'";
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
