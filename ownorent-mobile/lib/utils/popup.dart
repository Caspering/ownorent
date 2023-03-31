import 'package:flutter/material.dart';
import 'package:ownorent/ui/shared/loader.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:quickalert/quickalert.dart';

class PopUp {
  Future popLoad(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: Loader());
        });
  }

  showError(context, text) {
    QuickAlert.show(
        context: context,
        text: text,
        type: QuickAlertType.error,
        textColor: ownorentPurple,
        titleColor: ownorentPurple,
        confirmBtnColor: ownorentPurple);
  }

  showInfo(context, text) {
    QuickAlert.show(
        context: context,
        text: text,
        textColor: ownorentPurple,
        titleColor: ownorentPurple,
        type: QuickAlertType.info,
        confirmBtnColor: ownorentPurple);
  }

  showSuccess(context, text) {
    QuickAlert.show(
        context: context,
        text: text,
        textColor: ownorentPurple,
        titleColor: ownorentPurple,
        type: QuickAlertType.success,
        confirmBtnColor: ownorentPurple);
  }
}
