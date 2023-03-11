import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/core/viewmodels/user_viewmodel.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/custom_textfield.dart';
import 'profile_picture.dart';

class Fullname extends StatefulWidget {
  const Fullname({super.key});

  @override
  State<Fullname> createState() => _FullnameState();
}

class _FullnameState extends State<Fullname> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  bool? isPhoneNumber;
  TextEditingController _phoneField = TextEditingController();
  bool? isFname;
  bool? isLname;
  @override
  Widget build(BuildContext context) {
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
      ),
      body: Container(
          //  alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ownorentWhite,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      "Complete registration 1/3",
                      style: TextStyle(
                          color: ownorentPurple,
                          fontSize: TextSize().p(context)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Add your details",
                      style: TextStyle(
                          color: ownorentPurple,
                          fontWeight: FontWeight.w500,
                          fontSize: TextSize().h1(context)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Please enter your first, last name and phone number",
                      style: TextStyle(
                          color: ownorentPurpleGrey,
                          fontSize: TextSize().h3(context)),
                    ),
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: CustomTextField(
                            onChanged: (String text) {
                              if (text.length > 1) {
                                setState(() {
                                  isFname = true;
                                });
                              } else {
                                setState(() {
                                  isFname = false;
                                });
                              }
                            },
                            hintText: "First name",
                            errorText: isFname == false
                                ? "first name must be more than 1 characters"
                                : null,
                            controller: _firstName,
                            // prefix: Icons.person_outline_rounded,
                          ))),
                  Center(
                      child: Container(
                          // margin: EdgeInsets.only(top),
                          child: CustomTextField(
                    onChanged: (String text) {
                      if (text.length > 1) {
                        setState(() {
                          isLname = true;
                        });
                      } else {
                        setState(() {
                          isLname = false;
                        });
                      }
                    },

                    errorText: isLname == false
                        ? "last name must be more than 1 characters"
                        : null,
                    hintText: "Last name",
                    controller: _lastName,
                    // prefix: Icons.person_outline_rounded,
                  ))),
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: CustomTextField(
                            onChanged: (String text) {
                              if (text.length == 11) {
                                setState(() {
                                  isPhoneNumber = true;
                                });
                              } else {
                                setState(() {
                                  isPhoneNumber = false;
                                });
                              }
                            },
                            hintText: "Phone number",
                            errorText: isPhoneNumber == false
                                ? "Phone number must be 11 characters"
                                : null,
                            controller: _phoneField,
                            // prefix: Icons.person_outline_rounded,
                          ))),
                  Expanded(child: Container()),
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 60,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: ownorentPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: isFname == true && isLname == true
                          ? () {
                              _userViewModel.setFirstname(_firstName.text);
                              _userViewModel.setLastname(_lastName.text);
                              _userViewModel
                                  .setPhoneNumber(_phoneField.text.trim());
                              RouteController().push(context, ProfilePicture());
                              print(_userViewModel.firstname);
                            }
                          : null,
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: ownorentWhite,
                            fontSize: TextSize().h3(context)),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
