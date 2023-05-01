import 'package:flutter/material.dart';
import 'package:ownorent/core/viewmodels/tailor_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../core/services/location_service.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/roles.dart';
import '../../utils/router.dart';
import '../shared/dropdown.dart';
import '../shared/icon_circle.dart';
import 'location_set_view.dart';

class PurposeScreen extends StatefulWidget {
  const PurposeScreen({super.key});

  @override
  State<PurposeScreen> createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewmodel>(context);
    final _tailorViewmodel = Provider.of<TailorViewmodel>(context);
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
          title: Text(
            "1 of 2",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ownorentPurple,
                fontSize: TextSize().h3(context)),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ownorentWhite,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.question_mark,
                color: ownorentPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 1),
                child: Text(
                  "Lets make sure your find exactly what you want",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().p(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Where would you like to start please?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ownorentPurple,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Center(
                  child: CeoDropdown(
                items: roles,
                value: _tailorViewmodel.role,
                hint: "Purpose",
                onChanged: (value) {
                  _tailorViewmodel.setRole(value);
                },
              )),
              Expanded(child: Container()),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: _tailorViewmodel.role != null
                      ? ownorentPurple
                      : ownorentPurpleGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: _tailorViewmodel.role != null
                      ? () {
                          _tailorViewmodel.addRole(_tailorViewmodel.role);
                          RouteController().push(context, LocationSetView());
                        }
                      : null,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: ownorentWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              )),
              Container(
                height: 20,
              )
            ],
          ),
        ));
  }
}
