import 'package:bellshub/utils/constants.dart';
import 'package:bellshub/utils/shared_prefrence_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  initMethod() async {
    Constants.myName = await SharedPrefrenceUtils.getUserNameSharedPreference();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Flexible(
              child: ListView(children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient:
                          LinearGradient(colors: [Colors.pink, Colors.indigo])),
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient:
                          LinearGradient(colors: [Colors.grey, Colors.black])),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          child: Icon(
                            FontAwesomeIcons.userSecret,
                            size: 30,
                          )),
                      title: Text('Go Anonymous',
                      style: TextStyle(color: Colors.white,),),
                      trailing: Switch(value: false, onChanged: (value) {})),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.person,
                      size: 40,
                    ),
                    title: Text('Profile'),
                    trailing: Icon(
                      Icons.arrow_right_alt,
                      size: 42,
                      color: Colors.black,
                    )),
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
