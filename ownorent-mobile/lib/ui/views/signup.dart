import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/core/services/authentication.dart';
import 'package:ownorent/ui/views/intro_view.dart';
import 'package:ownorent/ui/views/name.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../shared/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ownorentWhite,
          elevation: 0.0,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: ownorentWhite,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.5,
                      margin: const EdgeInsets.only(top: 10),
                      // child: Image.asset(),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/undraw_Choosing_house_re_1rv7.png')))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      "Become\na home owner today",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().h1(context),
                          color: ownorentPurple),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 7),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      "Please enter your valid data\nin order to create an account",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().p(context),
                          color: ownorentPurpleGrey),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CustomTextField(
                        maxLines: 1,
                        hintText: "Email address",
                        controller: _emailField,
                        prefix: Icons.mail_outline_rounded,
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      child: CustomTextField(
                        maxLines: 1,
                        obscureText: true,
                        hintText: "Password",
                        controller: _passwordField,
                        prefix: Icons.lock_outline_rounded,
                      )),
                  Container(
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
                            .register(_emailField.text.trim(),
                                _passwordField.text.trim())
                            .then((value) {
                          RouteController()
                              .pushAndRemoveUntil(context, Fullname());
                        }).catchError((e) {
                          RouteController().pop(context);
                          PopUp().showError(context, e.message);
                          _passwordField.clear();
                        });
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: ownorentWhite,
                            fontSize: TextSize().h3(context)),
                      ),
                    ),
                  )
                ]))));
  }
}
