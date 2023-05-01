import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/viewmodels/tailor_viewmodel.dart';
import 'package:ownorent/ui/shared/custom_textfield.dart';
import 'package:ownorent/ui/views/name.dart';
import 'package:ownorent/utils/popup.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/services/location_service.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/roles.dart';
import '../../utils/router.dart';
import '../shared/dropdown.dart';
import '../shared/icon_circle.dart';
import 'app_index.dart';

class LocationSetView extends StatefulWidget {
  const LocationSetView({super.key});

  @override
  State<LocationSetView> createState() => _LocationSetViewState();
}

class _LocationSetViewState extends State<LocationSetView> {
  TextEditingController _queryField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewmodel>(context);
    final _tailorViewmodel = Provider.of<TailorViewmodel>(context);
    final locationService = Provider.of<LocationService>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
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
          "2 of 2",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: ownorentPurple,
              fontSize: TextSize().h3(context)),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
        color: ownorentWhite,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.add_location,
                color: ownorentPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "In what location do you want to start searching?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ownorentPurple,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1),
                child: Text(
                  "You can search cities, neighbourhoods and zip codes",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().p(context)),
                ),
              ),
              CustomTextField(
                hintText: 'Type anything',
                controller: _queryField,
                action: TextInputAction.search,
                onSubmit: (value) async {
                  PopUp().popLoad(context);
                  await _tailorViewmodel.searchLocation(value).then((value) {
                    RouteController().pop(context);
                    _tailorViewmodel.setSaveLocation(value['name']);
                    _tailorViewmodel.setCoordinates(
                        value["coord"]["lat"], value["coord"]["lon"]);
                  }).catchError((e) {
                    RouteController().pop(context);
                    PopUp().showError(context, e.toString());
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  PopUp().popLoad(context);
                  _queryField.clear();
                  _tailorViewmodel
                      .getUserLocation(
                          locationService.userCoordinates ?? LatLng(0.0, 0.0))
                      .then((value) {
                    RouteController().pop(context);
                    _tailorViewmodel.setSaveLocation(value);
                    _tailorViewmodel.setCoordinates(
                        locationService.userCoordinates?.latitude ?? 0.0,
                        locationService.userCoordinates?.longitude ?? 0.0);
                  }).catchError((e) {
                    RouteController().pop(context);
                    PopUp().showError(context, e.toString());
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Or use my current location',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        fontSize: TextSize().p(context)),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ownorentPurple,
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  'Location: ${_tailorViewmodel.location ?? ""}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ownorentWhite,
                      fontSize: TextSize().p(context)),
                ),
              ),
              Expanded(child: Container()),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                decoration: BoxDecoration(
                  color: _tailorViewmodel.location != ""
                      ? ownorentPurple
                      : ownorentPurpleGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: _tailorViewmodel.location != ""
                      ? () async {
                          PopUp().popLoad(context);
                          _tailorViewmodel.addLocation(
                              _tailorViewmodel.location,
                              _tailorViewmodel.lat,
                              _tailorViewmodel.long);

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
                      : null,
                  child: Text(
                    "Done",
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
        )),
      ),
    );
  }
}
