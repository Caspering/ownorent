import 'package:flutter/material.dart';
import 'package:ownorent/utils/popup.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/custom_textfield.dart';
import '../shared/icon_circle.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  TextEditingController _firstnameField = TextEditingController();
  TextEditingController _secondnameField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    _firstnameField.text = userViewModel.firstname ?? "";
    _secondnameField.text = userViewModel.lastname ?? "";
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
        height: MediaQuery.of(context).size.height / 1.1,
        width: MediaQuery.of(context).size.width,
        color: ownorentWhite,
        padding: EdgeInsets.only(left: 10, right: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.edit,
                color: ownorentPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Change your name",
                  style: TextStyle(
                      color: ownorentPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h2(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  "Change your first and second name",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Center(
                child: CustomTextField(
                  hintText: "First Name",
                  controller: _firstnameField,
                  maxLines: 1,
                  onChanged: (text) {
                    userViewModel.setFirstname(text);
                    print(userViewModel.firstname);
                  },
                ),
              ),
              Center(
                child: CustomTextField(
                  hintText: "Last Name",
                  controller: _secondnameField,
                  maxLines: 1,
                  onChanged: (text) {
                    userViewModel.setLastname(text);
                    print(userViewModel.lastname);
                  },
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
                  onPressed: () {
                    if (_firstnameField.text.length > 2 &&
                        _secondnameField.text.length > 2) {
                      userViewModel.currentUser?.firstname =
                          userViewModel.firstname;
                      userViewModel.currentUser?.lastname =
                          userViewModel.lastname;
                      userViewModel.updateUserName(userViewModel.firstname,
                          userViewModel.lastname, _auth.userId);

                      PopUp().showSuccess(context, "Name Updated successfully");
                    } else {
                      PopUp().showSuccess(context, "Name Updated successfully");
                    }
                  },
                  child: Text(
                    "Update Name",
                    style: TextStyle(
                        color: ownorentWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
