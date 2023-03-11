import 'package:flutter/material.dart';
import 'package:ownorent/ui/views/appointments_view.dart';
import 'package:ownorent/ui/views/change_password_view.dart';
import 'package:ownorent/ui/views/delete_account_view.dart';
import 'package:ownorent/ui/views/favorites_view.dart';
import 'package:ownorent/ui/views/intro_view.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../shared/avatar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewmodel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ownorentWhite,
        elevation: 0.0,
        leading: Avatar(),
        title: Text(
          '${userViewModel.currentUser?.firstname} ${userViewModel.currentUser?.lastname}',
          style: TextStyle(
              color: ownorentPurple, fontSize: TextSize().h3(context)),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: ownorentPurpleGrey,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: ownorentWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Ownorent",
                      style: TextStyle(
                          color: ownorentPurple,
                          fontSize: TextSize().p(context),
                          fontWeight: FontWeight.w600),
                    ),
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
                    ListTile(
                      onTap: () {
                        RouteController().push(context, CalendarView());
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(
                        Icons.tour,
                        size: TextSize().h1(context),
                        color: ownorentPurple,
                      ),
                      title: Text(
                        "Tours",
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
                    ListTile(
                      onTap: () {
                        RouteController().push(context, FavoritesView());
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(
                        Icons.favorite,
                        size: TextSize().h1(context),
                        color: ownorentPurple,
                      ),
                      title: Text(
                        "Favorites",
                        style: TextStyle(
                            color: ownorentPurple,
                            fontSize: TextSize().p(context),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: ownorentWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Account",
                      style: TextStyle(
                          color: ownorentPurple,
                          fontSize: TextSize().p(context),
                          fontWeight: FontWeight.w600),
                    ),
                    ListTile(
                      onTap: () {
                        RouteController().push(context, ChangePassword());
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(
                        Icons.password,
                        size: TextSize().h1(context),
                        color: ownorentPurple,
                      ),
                      title: Text(
                        "Change password",
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
                    ListTile(
                      onTap: () async {
                        await _auth.signOut();
                        RouteController()
                            .pushAndRemoveUntil(context, IntroView());
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(
                        Icons.logout,
                        size: TextSize().h1(context),
                        color: ownorentPurple,
                      ),
                      title: Text(
                        "Logout",
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
                    ListTile(
                      onTap: () {
                        RouteController().push(context, DeleteAccount());
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(
                        Icons.delete_forever,
                        size: TextSize().h1(context),
                        color: ownorentRed,
                      ),
                      title: Text(
                        "Delete Account",
                        style: TextStyle(
                            color: ownorentRed,
                            fontSize: TextSize().p(context),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}