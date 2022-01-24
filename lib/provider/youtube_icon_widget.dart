import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String string;
  final Color iconColor;
  final Color textColor;
  final double iconSize;

  IconText({
    required this.textColor,
    required this.iconColor,
    required this.string,
    required this.iconSize,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          string,
          style: TextStyle(
              color: Colors.red, fontSize: 10, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
