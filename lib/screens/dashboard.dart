import 'package:flutter/material.dart';

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
        title: Text('BellsHub'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Flexible(
                child: ListView(children: [
              Material(
                child: InkWell(
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
                              SizedBox(height:12),
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
              )
            ])),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(52),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child:
                          IconButton(icon: Icon(Icons.home), onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.chat_bubble_outline_sharp),
                          onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(Icons.rv_hookup), onPressed: () {},color: Colors.blueGrey[200],),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
