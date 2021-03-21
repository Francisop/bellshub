import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:bellshub/screens/group/create_groups.dart/add_friends.dart';
import 'package:bellshub/screens/group/create_groups.dart/group_info.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final remote = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            items: [GroupInfo(remote), AddFriends()],
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
