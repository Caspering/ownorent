// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/core/viewmodels/house_viewmodel.dart';
import 'package:ownorent/ui/views/house_description.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';

class MyHouses extends StatefulWidget {
  const MyHouses({super.key});

  @override
  State<MyHouses> createState() => _MyHousesState();
}

class _MyHousesState extends State<MyHouses> {
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ownorentWhite,
        elevation: 0.0,
        title: Text(
          "My homes",
          style: TextStyle(
              color: ownorentPurple, fontSize: TextSize().h3(context)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                RouteController().push(context, HouseDescription());
              },
              icon: Icon(
                Icons.add_home,
                color: ownorentPurple,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ownorentWhite,
      ),
    );
  }
}
