import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';
import '../shared/custom_textfield.dart';
import '../shared/icon_circle.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ownorentWhite,
          leading: IconButton(
            onPressed: () {
              RouteController().pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ownorentPurple,
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width,
            color: ownorentWhite,
            padding: EdgeInsets.only(left: 10, right: 5),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconCircle(
                  icon: Icons.lock,
                  color: ownorentPurple,
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    "Change your password",
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: TextSize().h2(context)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    "Change your password to any new password of your choice",
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontSize: TextSize().h3(context)),
                  ),
                ),
                Center(
                  child: CustomTextField(
                    hintText: "Old password",
                    controller: _oldPassword,
                    obscureText: true,
                    maxLines: 1,
                  ),
                ),
                Center(
                  child: CustomTextField(
                    hintText: "New password",
                    controller: _newPassword,
                    obscureText: true,
                    maxLines: 1,
                  ),
                ),
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 60,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: ownorentPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      PopUp().popLoad(context);
                      await _auth
                          .updatePassword(_oldPassword.text.trim(),
                              _newPassword.text.trim())
                          .then((value) {
                        RouteController().pop(context);
                        PopUp().showSuccess(
                            context, "password updated successfully");
                      }).catchError((e) {
                        RouteController().pop(context);
                        PopUp().showError(context, e.message);
                      });
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: ownorentWhite,
                          fontSize: TextSize().h3(context)),
                    ),
                  ),
                ))
              ],
            ))));
  }
}
