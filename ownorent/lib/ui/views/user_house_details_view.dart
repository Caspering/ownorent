import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/favorite_viewmodel.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/date.dart';
import '../../utils/font_size.dart';
import '../../utils/formatter.dart';
import '../../utils/router.dart';

class UserHouseDetails extends StatefulWidget {
  const UserHouseDetails({super.key});

  @override
  State<UserHouseDetails> createState() => _UserHouseDetailsState();
}

class _UserHouseDetailsState extends State<UserHouseDetails> {
  @override
  Widget build(BuildContext context) {
    FavoriteViewModel _favorites = Provider.of<FavoriteViewModel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back,
            color: ownorentPurple,
          ),
        ),
        title: Text(
          'House in ${_houseViewmodel.currentHouse?.area}',
          style: TextStyle(
              color: ownorentPurple,
              fontSize: TextSize().p(context),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: _houseViewmodel.currentHouse?.images?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          _houseViewmodel.currentHouse?.images?[index]))),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.1,
            );
          }),
      bottomSheet: SolidBottomSheet(
          elevation: 5.0,
          headerBar: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 15, bottom: 16, left: 16, right: 16),
            color: ownorentWhite,
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${getCurrency()}${formatMoney(int.parse(_houseViewmodel.currentHouse?.price ?? ""))}',
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context)),
                  ),
                  Text(
                    'Price',
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().small(context)),
                  ),
                ]),
                Expanded(child: Container()),
                Column(children: [
                  Text(
                    _houseViewmodel.currentHouse?.bedroomNumber ?? "",
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context)),
                  ),
                  Text(
                    'Beds',
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().small(context)),
                  ),
                ]),
                Container(
                  width: 20,
                ),
                Column(children: [
                  Text(
                    _houseViewmodel.currentHouse?.bathroomNumber ?? "",
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context)),
                  ),
                  Text(
                    'Baths',
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().small(context)),
                  ),
                ]),
                Container(
                  width: 20,
                ),
                Column(children: [
                  Text(
                    '${DateTimeFormatter().timeDifference(_houseViewmodel.currentHouse?.dateAdded)} ',
                    style: TextStyle(
                        color: ownorentPurple,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context)),
                  ),
                  Text(
                    'Ago',
                    style: TextStyle(
                        color: ownorentPurpleGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().small(context)),
                  ),
                ]),
              ],
            ),
          ),
          body: Container(
            color: ownorentWhite,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: ownorentPurpleGrey,
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 15, bottom: 10, right: 15),
                  child: Text(
                    '${_houseViewmodel.currentHouse?.accomodationType} for ${_houseViewmodel.currentHouse?.type}',
                    style: TextStyle(
                      color: ownorentPurple,
                      fontSize: TextSize().small(context),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 15, bottom: 10, right: 15),
                  child: Text(
                    '@ ${_houseViewmodel.currentHouse?.address}',
                    style: TextStyle(
                      color: ownorentPurple,
                      fontSize: TextSize().h3(context),
                    ),
                  ),
                ),
                Divider(
                  color: ownorentPurpleGrey,
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 15, bottom: 10, right: 15),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: ownorentPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: TextSize().p(context),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 15, bottom: 10, right: 15),
                  child: Text(
                    '${_houseViewmodel.currentHouse?.description}',
                    style: TextStyle(
                      color: ownorentPurple,
                      fontSize: TextSize().p(context),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
