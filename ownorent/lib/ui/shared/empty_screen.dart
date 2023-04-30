import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';

import '../../utils/font_size.dart';

class Empty extends StatefulWidget {
  @override
  EmptyState createState() => EmptyState();
}

class EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ownorentWhite,
        child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4,

              // child: Image.asset(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/undraw_Empty_re_opql copy.png')))),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Nothing to see here",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TextSize().h1(context),
                  color: ownorentPurple),
            ),
          ),
        ]),
      ),
    );
  }
}
