import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/popup.dart';

import '../../utils/font_size.dart';
import '../../utils/router.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage(
                          'assets/undraw_Choosing_house_re_1rv7.png')))),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Find the\nperfect place",
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
                    "post your specs and budget\nand get highly relevant matches",
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
              // width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ownorentPurple)),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: ownorentPurple,
                            fontSize: TextSize().h3(context)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ownorentPurple,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ownorentPurple)),
                    child: MaterialButton(
                      onPressed: () {
                        PopUp().showSuccess(context, "Done successfully");
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: ownorentWhite,
                            fontSize: TextSize().h3(context)),
                      ),
                    ),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
