import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back,
            color: ownorentPurple,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
              color: ownorentPurple,
              fontSize: TextSize().p(context),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ownorentWhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.smart_display,
                  size: TextSize().h1(context),
                  color: ownorentPurple,
                ),
                title: Text(
                  "Advertise a listing",
                  style: TextStyle(
                      color: ownorentPurple,
                      fontSize: TextSize().p(context),
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                thickness: 0.5,
                color: greyOne,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
