import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'basic_info.dart';
import 'upload_id_card_step.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final remote = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            items: [
              BasicInfo(),
              UploadIdCardStep()
            ],
            options: CarouselOptions(
              disableCenter: true,
              height: MediaQuery.of(context).size.height * 0.8,
              viewportFraction: 10,
              // pageSnapping: false,
            ),
            carouselController: remote,
          ),
        ),
        ElevatedButton(
          onPressed: () => remote.nextPage(
              duration: Duration(milliseconds: 1000), curve: Curves.linear),
          child: Text('→'),
        )
      ],
    );
  }
}
