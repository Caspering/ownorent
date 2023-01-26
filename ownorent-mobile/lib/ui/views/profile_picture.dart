import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ownorent/core/models/user_model.dart';
import 'package:ownorent/ui/views/app_index.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';

class ProfilePicture extends StatefulWidget {
  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    Future getImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        userViewModel.setImage(_image);
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
          //  alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ownorentWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "Complete registration 2/3",
                  style: TextStyle(
                      color: ownorentPurple, fontSize: TextSize().p(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Add a profile picture",
                  style: TextStyle(
                      color: ownorentPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h1(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "${userViewModel.firstname} please add a profile picture 📸",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Expanded(child: Container()),
              Center(
                  child: MaterialButton(
                      onPressed: getImage,
                      child: userViewModel.image == null
                          ? Container(
                              height: 200,
                              width: 200,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 100,
                                  color: ownorentPurpleGrey,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: greyOne),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(userViewModel.image!),
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
                  onPressed: userViewModel.image != null
                      ? () async {
                          if (userViewModel.imageUrl == null) {
                            PopUp().popLoad(context);
                            // ignore: avoid_single_cascade_in_expression_statements
                            userViewModel
                                .setImageUrl(
                                    userViewModel.image, authService.userId)
                                .then((value) {
                              userViewModel
                                  .adduser(
                                      Users(
                                          address: "",
                                          email: authService.user?.email,
                                          firstname: userViewModel.firstname,
                                          lastname: userViewModel.lastname,
                                          lat: 0.0,
                                          long: 0.0,
                                          isVerified: false,
                                          profilePhoto: userViewModel.imageUrl,
                                          phoneNumber:
                                              userViewModel.phoneNumber),
                                      authService.userId)
                                  .then((value) {
                                RouteController().pop(context);
                                RouteController()
                                    .pushAndRemoveUntil(context, AppIndex());
                              });

                              print(userViewModel.imageUrl);
                            });
                          } else {
                            userViewModel
                                .adduser(
                                    Users(
                                        address: "",
                                        email: authService.user?.email,
                                        firstname: userViewModel.firstname,
                                        lastname: userViewModel.lastname,
                                        lat: 0.0,
                                        long: 0.0,
                                        isVerified: false,
                                        profilePhoto: userViewModel.imageUrl,
                                        phoneNumber: userViewModel.phoneNumber),
                                    authService.userId)
                                .then((value) {
                              RouteController().pop(context);
                              RouteController()
                                  .pushAndRemoveUntil(context, AppIndex());
                            });
                          }
                        }
                      : () {
                          PopUp().showError(context, "Please add an image");
                        },
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
