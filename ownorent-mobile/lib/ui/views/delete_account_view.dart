import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ownorent/ui/views/intro_view.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';
import '../shared/custom_textfield.dart';
import '../shared/icon_circle.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController _passwordField = TextEditingController();
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
                  icon: Icons.delete,
                  color: ownorentRed,
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    "Delete your account",
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: TextSize().h2(context)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    "Enter your password to complete this operation",
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontSize: TextSize().h3(context)),
                  ),
                ),
                Center(
                  child: CustomTextField(
                    hintText: "password",
                    controller: _passwordField,
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
                          .deleteAccount(_passwordField.text.trim())
                          .then((value) {
                        RouteController()
                            .pushAndRemoveUntil(context, IntroView());
                      }).catchError((e) {
                        RouteController().pop(context);
                        PopUp().showError(context, e.message);
                      });
                    },
                    child: Text(
                      "Delete Account",
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
