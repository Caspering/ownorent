import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/ui/shared/empty_screen.dart';
import 'package:ownorent/ui/shared/users_row_widget.dart';
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
        // height: MediaQuery.of(context).size.height,
        color: ownorentWhite,
        child: FutureBuilder<List<House>>(
            future: _houseViewmodel.getFeed(LatLng(
                _tailorViewmodel.lat ?? 0.0, _tailorViewmodel.long ?? 0.0)),
            builder: (context, snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Empty();
                } else {
                  print(snapshot.data?.length);
                  int mid = snapshot.data!.length ~/ 2;
                  List<House> left = snapshot.data!.sublist(0, mid);
                  List<House> right = snapshot.data!.sublist(mid);
                  return ListView(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: left.length,
                          itemBuilder: (context, index) {
                            return FeedContainer(
                              onTapped: () {
                                _houseViewmodel.setCurrentHouse(left[index]);
                                print(_houseViewmodel
                                    .currentHouse?.accomodationType);
                                RouteController()
                                    .push(context, const HouseDetailView());
                              },
                              isPromoted: false,
                              docId: left[index].id ?? "",
                              address: left[index].address ?? "",
                              bathroom: left[index].bathroomNumber ?? "",
                              bedroom: left[index].bedroomNumber ?? "",
                              price: left[index].price ?? "",
                              dateAdded: left[index].dateAdded,
                              mainImage: left[index].images?[0],
                            );
                          }),
                      // UserRowWidget(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: right.length,
                          itemBuilder: (context, index) {
                            return FeedContainer(
                              onTapped: () {
                                _houseViewmodel.setCurrentHouse(right[index]);
                                print(_houseViewmodel
                                    .currentHouse?.accomodationType);
                                RouteController()
                                    .push(context, const HouseDetailView());
                              },
                              isPromoted: false,
                              docId: right[index].id ?? "",
                              address: right[index].address ?? "",
                              bathroom: right[index].bathroomNumber ?? "",
                              bedroom: right[index].bedroomNumber ?? "",
                              price: right[index].price ?? "",
                              dateAdded: right[index].dateAdded,
                              mainImage: right[index].images?[0],
                            );
                          })
                    ],
                  );
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
