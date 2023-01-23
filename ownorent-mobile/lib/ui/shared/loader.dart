import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';

class Loader extends StatefulWidget {
  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 1.1,
      color: ownorentWhite,
      child: Center(
        child: CircularProgressIndicator(
          color: ownorentPurple,
        ),
      ),
    );
  }
}
