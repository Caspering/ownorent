import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:ownorent/core/models/user_model.dart';
import 'package:ownorent/core/viewmodels/user_viewmodel.dart';
import 'package:ownorent/ui/shared/avatar.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HouseOwnerCard extends StatefulWidget {
  final String ownerId;
  final String role;
  HouseOwnerCard({super.key, required this.ownerId, required this.role});

  @override
  State<HouseOwnerCard> createState() => _HouseOwnerCardState();
}

class _HouseOwnerCardState extends State<HouseOwnerCard> {
  @override
  Widget build(BuildContext context) {
    UserViewmodel _userViewmodel = Provider.of<UserViewmodel>(context);
    return FutureBuilder<Users?>(
        future: _userViewmodel.getUserById(widget.ownerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data?.profilePhoto ?? ""),
                  ),
                  title: Text(
                    '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: TextSize().p(context)),
                  ),
                  subtitle: Text(widget.role,
                      style: TextStyle(
                          color: ownorentPurpleGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: TextSize().small(context))),
                  trailing: IconButton(
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: snapshot.data?.phoneNumber,
                        );
                        await launchUrl(launchUri);
                      },
                      icon: Icon(
                        Icons.call,
                        size: TextSize().h2(context),
                        color: ownorentPurple,
                      )),
                ));
          } else {
            return Container();
          }
        });
  }
}
