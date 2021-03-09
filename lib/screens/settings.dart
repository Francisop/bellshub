import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
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
                ListTile(
                  leading: CircleAvatar(radius: 40, child: Icon(Icons.ac_unit)),
                  trailing: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.logout)),
                  title: Text(
                    'Welcome',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Madeline Duke',
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Divider(),
                SizedBox(
                  height: 14,
                ),
                ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          FontAwesomeIcons.userSecret,
                        )),
                    title: Text('Go Anonymous'),
                    trailing: Switch(value: true, onChanged: (value) {})),
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
                color: Colors.black,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copyright, color: Colors.white),
                    Text(
                      'Blaccop20Apps',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
