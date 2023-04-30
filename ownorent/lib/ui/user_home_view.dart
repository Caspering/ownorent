import 'package:flutter/material.dart';
import 'package:ownorent/ui/views/house_detail_view.dart';
import 'package:ownorent/ui/widgets/user_house_container.dart';
import 'package:provider/provider.dart';

import '../core/models/house_model.dart';
import '../core/services/authentication.dart';
import '../core/viewmodels/house_viewmodel.dart';
import '../core/viewmodels/user_viewmodel.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/router.dart';
import 'shared/empty_screen.dart';
import 'views/house_description.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
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
        child: FutureBuilder<List<House>>(
            future: _houseViewmodel.getUserHomes(_auth.userId!.trim()),
            builder: (context, snapshot) {
              print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Empty();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return UserhouseContainer(
                            house: snapshot.data?[index] ?? House());
                      });
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: ownorentPurple,
                  ),
                );
              }
            }),
      ),
    );
  }
}
