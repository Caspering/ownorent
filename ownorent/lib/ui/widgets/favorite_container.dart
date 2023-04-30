import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/ui/widgets/feed_container.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/viewmodels/favorite_viewmodel.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../utils/router.dart';
import '../views/house_detail_view.dart';

class FavoritesContainer extends StatefulWidget {
  final String id;
  const FavoritesContainer({super.key, required this.id});

  @override
  State<FavoritesContainer> createState() => _FavoritesContainerState();
}

class _FavoritesContainerState extends State<FavoritesContainer> {
  @override
  Widget build(BuildContext context) {
    FavoriteViewModel _favorites = Provider.of<FavoriteViewModel>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    return FutureBuilder<House>(
        future: _houseViewmodel.getHouseById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return FeedContainer(
                address: snapshot.data?.address ?? "",
                docId: snapshot.data?.id ?? "",
                isPromoted: false,
                bathroom: snapshot.data?.bathroomNumber ?? "",
                bedroom: snapshot.data?.bedroomNumber ?? "",
                price: snapshot.data?.price ?? "",
                mainImage: snapshot.data?.images?[0],
                dateAdded: snapshot.data?.dateAdded,
                onTapped: () {
                  _houseViewmodel.setCurrentHouse(snapshot.data);
                  print(_houseViewmodel.currentHouse?.accomodationType);
                  RouteController().push(context, HouseDetailView());
                });
          } else {
            return Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.2,
              margin: EdgeInsets.all(10),
              color: greyOne,
            ).shimmer();
          }
        });
  }
}
