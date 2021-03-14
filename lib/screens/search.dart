import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  var searchSnapshot;
  Search(this.searchSnapshot);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 25, right: 15, top: 15),
              title: Text('Search🔎', style: TextStyle(fontSize: 20)),
              subtitle: Text(
                  'Find People in bells,hookup,spookup and get intouch',
                  style: TextStyle(fontSize: 12)),
            ),
            SizedBox(),
            Container(
              padding: EdgeInsets.all(12),
              height: 70.0,
              child: TextFormField(
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      prefixIcon: IconButton(
                        onPressed: () {
                          print('icon clicked');
                        },
                        icon: Icon(Icons.search),
                      ),
                      hintText: 'Search...',
                      fillColor: Colors.grey.shade100,
                      filled: true)),
            ),
          ],
        )),
      ),
    );
  }
}
