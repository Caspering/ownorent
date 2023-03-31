import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/popup.dart';
import '../../utils/router.dart';
import '../shared/icon_circle.dart';

class UpdatePicture extends StatefulWidget {
  const UpdatePicture({super.key});

  @override
  State<UpdatePicture> createState() => _UpdatePictureState();
}

class _UpdatePictureState extends State<UpdatePicture> {
  File? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
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
        height: MediaQuery.of(context).size.height / 1.1,
        width: MediaQuery.of(context).size.width,
        color: ownorentWhite,
        padding: EdgeInsets.only(left: 10, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconCircle(
              icon: Icons.person,
              color: ownorentPurple,
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(
                "Change your Picture",
                style: TextStyle(
                    color: ownorentPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: TextSize().h2(context)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                "Change your profile picture to something else",
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
                        ? CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                                userViewModel.currentUser!.profilePhoto ?? ""),
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
                onPressed: () async {
                  if (userViewModel.image == null) {
                    userViewModel.updateProfilePhoto(
                        userViewModel.currentUser?.profilePhoto, _auth.userId);
                    setState(() {});
                  } else {
                    PopUp().popLoad(context);
                    userViewModel
                        .setImageUrl(userViewModel.image, _auth.userId)
                        .then((value) {
                      userViewModel.updateProfilePhoto(
                          userViewModel.imageUrl, _auth.userId);
                      userViewModel.currentUser?.profilePhoto =
                          userViewModel.imageUrl;
                      RouteController().pop(context);
                      PopUp().showSuccess(
                          "Profile picture updated successfully", context);
                      print(userViewModel.imageUrl);
                    });
                  }
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
      ),
    );
  }
}
