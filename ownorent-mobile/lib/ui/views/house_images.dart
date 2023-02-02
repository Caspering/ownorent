// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/core/viewmodels/house_viewmodel.dart';
import 'package:ownorent/ui/views/app_index.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/services/location_service.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';
import '../shared/icon_circle.dart';

class HouseImages extends StatefulWidget {
  const HouseImages({super.key});

  @override
  State<HouseImages> createState() => _HouseImagesState();
}

class _HouseImagesState extends State<HouseImages> {
  File? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    LocationService _location = Provider.of<LocationService>(context);
    Future getImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _houseViewmodel.addFileImages(_image);
      } else {
        return;
      }
    }

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
                    icon: Icons.add_a_photo,
                    color: ownorentPurple,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      "Pictures of your listing",
                      style: TextStyle(
                          color: ownorentPurple,
                          fontWeight: FontWeight.w500,
                          fontSize: TextSize().h2(context)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Text(
                      "Images of the interior and exterior of the house you want to sell",
                      style: TextStyle(
                          color: ownorentPurpleGrey,
                          fontSize: TextSize().h3(context)),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Center(
                    child: MaterialButton(
                        onPressed: getImage,
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_constructors
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                Icon(
                                  Icons.image,
                                  size: 80,
                                  color: ownorentPurple,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Add home images",
                                    style: TextStyle(
                                        color: ownorentPurple,
                                        fontSize: TextSize().h3(context)),
                                  ),
                                ),
                              ])),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: greyOne),
                        )),
                  ),
                  Container(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _houseViewmodel.fileImages.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                  background: Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: ownorentWhite,
                                      ),
                                    ),
                                    color: ownorentRed,
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                  ),
                                  direction: DismissDirection.down,
                                  onDismissed: (direction) {
                                    _houseViewmodel.removeFileImage(
                                        _houseViewmodel.fileImages[index]);
                                  },
                                  key: Key(
                                      _houseViewmodel.fileImages[index].path),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_houseViewmodel
                                                .fileImages[index])),
                                        color: ownorentPurpleGrey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    // color: ownorentPurple,
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                  ));
                            })),
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
                        if (_houseViewmodel.fileImages.length >= 3) {
                          try {
                            PopUp().popLoad(context);
                            List<String> urls = await _houseViewmodel
                                .setHomeImages(_houseViewmodel.fileImages);

                            await _houseViewmodel.addHouse(House(
                              accomodationType: _houseViewmodel.houseType,
                              address: _houseViewmodel.address,
                              bathroomNumber: _houseViewmodel.bathroomNumber,
                              bedroomNumber: _houseViewmodel.bedroomNumber,
                              description: _houseViewmodel.description,
                              images: urls,
                              locationLat: _houseViewmodel.houseLat,
                              locationLong: _houseViewmodel.houseLong,
                              ownersId: _auth.userId,
                              type: _houseViewmodel.paymentType,
                            ));
                            RouteController()
                                .pushAndRemoveUntil(context, AppIndex());
                          } catch (e) {
                            RouteController().pop(context);
                            PopUp().showError(context, e.toString());
                          }
                        } else {
                          PopUp().showError(context, "Add up to 5 images");
                        }
                      },
                      child: Text(
                        "Add House",
                        style: TextStyle(
                            color: ownorentWhite,
                            fontSize: TextSize().h3(context)),
                      ),
                    ),
                  ))
                ]))));
  }
}
