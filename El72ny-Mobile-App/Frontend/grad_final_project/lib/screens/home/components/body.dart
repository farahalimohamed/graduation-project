import 'package:flutter/material.dart';

import 'call_emergency.dart';
import 'categories.dart';
import 'header_with_searchbox.dart';
import 'title_with_customunderline.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithCustomUnderline(text: 'What do you need ?',),
          HorizontalListPage(),
          CallEmergency(),
        ],
      ),
    );
  }
}