import 'package:bellshub/services/database_service.dart';
import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot userInfo;

  initMethod() async {
    Constants.myName = await SharedPrefrenceUtils.getUserNameSharedPreference();
    Constants.myEmail =
        await SharedPrefrenceUtils.getUserEmailSharedPreference();
    await databaseService.getUserByUserEmail(Constants.myEmail).then((e) {
      userInfo = e;
      print(userInfo.docs);
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
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Flexible(
              child: ListView(children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Colors.indigo.shade300,
                        Colors.indigo.shade300
                      ])),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Icon(Icons.person)),
                    trailing: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(Icons.logout)),
                    title: Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: Text(
                      Constants.myName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Divider(),
                SizedBox(
                  height: 14,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          child: Icon(
                            FontAwesomeIcons.userSecret,
                            size: 30,
                          )),
                      title: Text(
                        'Go Anonymous',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'incognito mode',
                      ),
                      trailing: Switch(value: false, onChanged: (value) {})),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Profile(userInfo);
                        });
                  },
                  leading: Icon(
                    Icons.person,
                    size: 40,
                  ),
                  title: Text('My profile'),
                  trailing: Icon(
                    Icons.arrow_right_alt,
                    size: 42,
                    color: Colors.black,
                  ),
                  subtitle: Text('fullname,gender,matric No,...'),
                ),
              ]),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copyright, color: Colors.grey[500]),
                    Text(
                      'Blaccop20Apps',
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
            )),
            // CustomBottomNavigationBar()
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final QuerySnapshot userInfo;
  Profile(this.userInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      // decoration:,
      child: Column(
        children: [
          Text(
           userInfo.docs[0].get('fullname'),
            style: TextStyle(color: Colors.black,fontSize: 21),
          ),
          SizedBox(height: 20,),
          Text(
             userInfo.docs[0].get('gender'),
            style: TextStyle(color: Colors.black,fontSize: 21),
          ),
          SizedBox(height: 20,),
          Text(
             userInfo.docs[0].get('matric'),
            style: TextStyle(color: Colors.black,fontSize: 21),
          ),
        ],
      ),
    );
  }
}
