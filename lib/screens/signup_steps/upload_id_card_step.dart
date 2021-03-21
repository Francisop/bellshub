import 'package:flutter/material.dart';

class UploadIdCardStep extends StatefulWidget {
  @override
  _UploadIdCardStepState createState() => _UploadIdCardStepState();
}

class _UploadIdCardStepState extends State<UploadIdCardStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      image: DecorationImage(
                          image: AssetImage('assets/img/default_id.jpg'),
                          fit: BoxFit.fill)),
                  height: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo.shade100,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.upload_rounded),
                    label: Text(
                      'Upload BellsTech ID card',
                      style: TextStyle(color: Colors.indigo[900]),
                    ),
                  )),
            ],
          )),
    ));
  }
}
