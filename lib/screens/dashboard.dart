import 'package:flutter/material.dart';
import 'package:bellshub/widgets/custom_bottom_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        title: Text('BellsHub'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.donut_small), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Flexible(
                child: ListView(children: [
              Material(
                child: GestureDetector(
                  onTap: () {
                    // TODO:add navigation animation
                    print('hello woorld froom public wall a');
                  },
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50.0)),
                      color: Colors.blueGrey[900],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                ),
                                onPressed: () {},
                              )),
                          SizedBox(height: 12),
                          Text('Public Wall',
                              style: TextStyle(
                                color: Colors.blueGrey[200],
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('F'),
                              radius: 40,
                            ),
                            title: Text('Coleng Group'),
                            subtitle: Text('Members:OsitaDinma,Amarachi,Iifeoluwa'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('F'),
                              radius: 40,
                            ),
                            title: Text('Coleng Group'),
                            subtitle: Text('Members:OsitaDinma,Amarachi,Iifeoluwa'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('F'),
                              radius: 40,
                            ),
                            title: Text('Coleng Group'),
                            subtitle: Text('Members:OsitaDinma,Amarachi,Iifeoluwa'),
                          ),
                        ),
                      ),
                    ),
          
                  ],
                ),
              ),
            ])),
          ),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }
}
