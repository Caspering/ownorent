// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/services/location_service.dart';
import 'package:ownorent/ui/shared/custom_textfield.dart';
import 'package:ownorent/ui/views/house_images.dart';
import 'package:ownorent/utils/popup.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/icon_circle.dart';

class HouseLocation extends StatefulWidget {
  const HouseLocation({super.key});

  @override
  State<HouseLocation> createState() => _HouseLocationState();
}

class _HouseLocationState extends State<HouseLocation> {
  TextEditingController _streetNumber = TextEditingController();
  TextEditingController _streetName = TextEditingController();
  TextEditingController _area = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    LocationService _location = Provider.of<LocationService>(context);
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
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: ownorentWhite,
          padding: EdgeInsets.only(left: 10, right: 5),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.location_pin,
                color: ownorentPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Location of your listing",
                  style: TextStyle(
                      color: ownorentPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h2(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  "Address of the house you want to sell",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Container(
                height: 10,
              ),
              Center(
                child: CustomTextField(
                    hintText: "Street number", controller: _streetNumber),
              ),
              Center(
                child: CustomTextField(
                    hintText: "Street name", controller: _streetName),
              ),
              Center(
                child: CustomTextField(hintText: "Area", controller: _area),
              ),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                margin: EdgeInsets.only(bottom: 10, top: 25),
                decoration: BoxDecoration(
                  color: ownorentPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    if (_area.text.length > 1) {
                      try {
                        PopUp().popLoad(context);
                        String address =
                            "${_streetName.text} ${_streetNumber.text}, ${_area.text}";
                        LatLng location =
                            await _location.getCoordinatesFromAddress(address);
                        _houseViewmodel.setArea(_area.text);
                        _houseViewmodel.setAddress(address);
                        _houseViewmodel.setHouseLat(location.latitude);
                        _houseViewmodel.setHouseLong(location.longitude);
                        RouteController().pop(context);
                        RouteController().push(context, HouseImages());
                      } on Exception catch (e) {
                        RouteController().pop(context);
                        PopUp().showError(context, e.toString());
                      }
                    } else {
                      PopUp().showError(context, "Please add your area");
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: ownorentWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              ))
            ],
          ))),
    );
  }
}
