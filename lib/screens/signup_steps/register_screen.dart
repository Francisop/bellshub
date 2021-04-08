import 'package:bellshub/screens/signup_steps/school_info.dart';
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
            items: [BasicInfo(remote), SchoolInfo(remote:remote), UploadIdCardStep()],
            options: CarouselOptions(
                disableCenter: true,
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                initialPage: 0,
                reverse: false,
                pageSnapping: false,
                scrollPhysics: NeverScrollableScrollPhysics()),
            carouselController: remote,
          ),
        ),
        // ElevatedButton(
        //   onPressed: () => remote.nextPage(
        //       duration: Duration(milliseconds: 1000), curve: Curves.linear),
        //   child: Text('→'),
        // )
      ],
    );
  }
}
