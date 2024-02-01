import 'package:flutter/material.dart';
import '../../../constants.dart';

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 2, // Adjust the bottom margin as needed
            left: 10,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: kDefaultPadding),
              height: 4,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xE6312C44),
              ),
            ),
          ),
        ],
      ),
    );
  }
}