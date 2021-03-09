import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DT { harder, smarter, selfStarter, tradingCharter }

class Converstion extends StatefulWidget {
  @override
  _ConverstionState createState() => _ConverstionState();
}

class _ConverstionState extends State<Converstion> {
  var _selection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Madeline Duke',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey.shade600,
        ),
        actions: [
          CircleAvatar(
            child: Icon(Icons.tv),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        child: Column(children: [
          // Flexible(
          //   child: ListView(
          //     children: [
          //       Container(
          //         color: Colors.red,
          //         height: 100,
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: IntrinsicHeight(
                        child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.amber),
                          child: TextField(
                            style: TextStyle(fontSize: 15.0, height: 1.0),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Message...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: CircleAvatar(
                            child: IconButton(
                                icon: Icon(Icons.send_rounded),
                                onPressed: () {})),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PopupMenuButton<DT>(
                            onSelected: (DT result) {
                              setState(() {
                                _selection = result;
                              });
                              print(_selection);
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<DT>>[
                              const PopupMenuItem<DT>(
                                value: DT.harder,
                                child: Text('send an image'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.smarter,
                                child: Text('Being a lot smarter'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.selfStarter,
                                child: Text('Being a self-starter'),
                              ),
                              const PopupMenuItem<DT>(
                                value: DT.tradingCharter,
                                child:
                                    Text('Placed in charge of trading charter'),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
