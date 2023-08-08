import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ownorent/ui/views/singin.dart';
import 'package:ownorent/utils/colors.dart';

import '../../utils/font_size.dart';
import '../../utils/router.dart';
import 'purpose_screen.dart';

class NotLogged extends StatefulWidget {
  const NotLogged({super.key});

  @override
  State<NotLogged> createState() => _NotLoggedState();
}

class _NotLoggedState extends State<NotLogged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ownorentWhite,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: ownorentWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Text(
              "Login to access this feature",
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TextSize().h3(context),
                  color: ownorentPurple),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width / 1.5,
              child: MaterialButton(
                  onPressed: () {
                    RouteController().push(context, Login());
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: TextSize().h3(context), color: ownorentWhite),
                  )),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: ownorentPurple, borderRadius: BorderRadius.circular(10)
                  //
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                RouteController().push(context, PurposeScreen());
              },
              child: Text(
                "Click here to update preferences",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: TextSize().p(context),
                    color: ownorentRed),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
