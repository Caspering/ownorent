import 'package:flutter/material.dart';
import 'package:ownorent/ui/shared/loader.dart';

class PopUp {
  Future popLoad(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: Loader());
        });
  }
}
