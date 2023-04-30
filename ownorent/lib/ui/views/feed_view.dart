import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/ui/shared/empty_screen.dart';
import 'package:ownorent/ui/views/house_detail_view.dart';
import 'package:ownorent/ui/widgets/feed_container.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../core/viewmodels/tailor_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/font_size.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    final _tailorViewmodel = Provider.of<TailorViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ownorentWhite,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Feed",
          style: TextStyle(
              color: ownorentPurple, fontSize: TextSize().h3(context)),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ownorentWhite,
        child: FutureBuilder<List<House>>(
            future: _houseViewmodel.getFeed(_tailorViewmodel.location ?? ""),
            builder: (context, snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Empty();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FeedContainer(
                          onTapped: () {
                            _houseViewmodel
                                .setCurrentHouse(snapshot.data?[index]);
                            print(
                                _houseViewmodel.currentHouse?.accomodationType);
                            RouteController()
                                .push(context, const HouseDetailView());
                          },
                          isPromoted: false,
                          docId: snapshot.data?[index].id ?? "",
                          address: snapshot.data?[index].address ?? "",
                          bathroom: snapshot.data?[index].bathroomNumber ?? "",
                          bedroom: snapshot.data?[index].bedroomNumber ?? "",
                          price: snapshot.data?[index].price ?? "",
                          dateAdded: snapshot.data?[index].dateAdded,
                          mainImage: snapshot.data?[index].images?[0],
                        );
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
