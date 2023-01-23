import 'package:flutter/material.dart';
import 'package:ownorent/core/services/authentication.dart';
import 'package:ownorent/ui/views/auth_view.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/font_size.dart';
import '../../utils/router.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ownorentWhite,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.only(top: 0),
              // child: Image.asset(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          AssetImage('assets/undraw_Best_place_re_lne9.png')))),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Find your\ndream place",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h(context),
                        color: ownorentPurple),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 7),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Welcome to ownorent\nWith ownorent we can save your time",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context),
                        color: ownorentPurpleGrey),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: MaterialButton(
                      onPressed: () async {
                        _auth.getAuthState();
                        if (_auth.authState == true) {
                          RouteController()
                              .pushAndRemoveUntil(context, IntroView());
                        } else {
                          RouteController().push(context, AuthView());
                        }
                      },
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Get started",
                        style: TextStyle(
                            fontSize: TextSize().h3(context),
                            color: ownorentWhite),
                      )),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      color: ownorentPurple,
                      borderRadius: BorderRadius.circular(30)
                      //
                      ),
                ),
              ))
        ]),
      ),
    );
  }
}
