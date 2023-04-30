import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/services/authentication.dart';
import 'package:ownorent/core/viewmodels/favorite_viewmodel.dart';
import 'package:ownorent/ui/views/auth_view.dart';
import 'package:ownorent/ui/views/name.dart';
import 'package:ownorent/ui/views/purpose_screen.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../core/services/location_service.dart';
import '../../core/viewmodels/tailor_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';
import 'app_index.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<LocationService>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    FavoriteViewModel _favorites = Provider.of<FavoriteViewModel>(context);
    final _tailorViewmodel = Provider.of<TailorViewmodel>(context);
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
                    "Find your\ndream house",
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
                        await _favorites.getFavourites();
                        String? role = await _tailorViewmodel.getRole();
                        String? location = await _tailorViewmodel.getLocation();
                        if (role != null && location != null) {
                          _tailorViewmodel.setRole(role);
                          _tailorViewmodel.setSaveLocation(location);
                        }
                        print(_tailorViewmodel.role);
                        print(_favorites.favoriteIds);
                        PopUp().popLoad(context);
                        _auth.getAuthState();

                        Position? position;
                        await locationService.getPosition()?.then((value) {
                          position = value;
                        }).catchError((e) {
                          position = null;
                        });
                        locationService.setCoordinates(LatLng(
                            position?.latitude ?? 0.0,
                            position?.longitude ?? 0.0));
                        RouteController().pop(context);
                        if (_tailorViewmodel.role == "" &&
                            _tailorViewmodel.location == "") {
                          RouteController().push(context, PurposeScreen());
                        } else {
                          if (_auth.authState == true) {
                            bool result =
                                await _userViewModel.checkIfUser(_auth.userId);
                            if (result == true) {
                              RouteController()
                                  .pushAndRemoveUntil(context, AppIndex());
                            } else {
                              RouteController().push(context, Fullname());
                            }
                          } else {
                            RouteController().push(context, AppIndex());
                          }
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
