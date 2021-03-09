import 'package:bellshub/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade50,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.indigo.shade50,
            title: Padding(
              padding: const EdgeInsets.only(top: 1.0, bottom: 8.0, left: 8.0),
              child: Text('Conversations',
                  style: TextStyle(fontSize: 20 , color: Colors.black87)),
            ),
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                // padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(3),
                      child: IconButton(
                          icon: Icon(Icons.search,size: 23,), onPressed: () {}),
                    ),
                    Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo,
                        ),
                        child: Text('Chats',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white))),
                    Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child:
                            Text('Hookups', style: TextStyle(fontSize: 15,color: Colors.grey))),
                    Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child:
                            Text('Archived', style: TextStyle(fontSize: 15,color: Colors.grey))),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
                  child: Container(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: Flexible(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.white),
                          child: ListTile(
                            
                            title: Text('Madeline Duke'),
                            subtitle: Text(
                              'Hello francis hoow are you today, my love i cant wait to see you',
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 20,
                              ),
                            ),
                            trailing: CircleAvatar(
                              child: Text('123'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomBottomNavigationBar()
            ]),
          ),
        ));
  }
}
