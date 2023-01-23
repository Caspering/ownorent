import 'package:flutter/material.dart';

class RouteController {
  pushAndRemoveUntil(context, view) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => view),
        (Route<dynamic> route) => false);
  }

  push(context, view) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
  }

  pop(context) {
    Navigator.of(context).pop(true);
  }
}
