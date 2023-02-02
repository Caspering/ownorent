import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';

import '../../utils/font_size.dart';

class IconCircle extends StatefulWidget {
  final IconData? icon;

  Color? color;
  IconCircle({this.icon, this.color});
  @override
  IconCircleState createState() => IconCircleState();
}

class IconCircleState extends State<IconCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.width / 7.5,
        width: MediaQuery.of(context).size.width / 7.5,
        child: Center(
          child: Icon(
            widget.icon,
            size: TextSize().h(context),
            color: ownorentWhite,
          ),
        ),
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(
                (MediaQuery.of(context).size.width / 7.5) / 2)),
      ),
    );
  }
}
