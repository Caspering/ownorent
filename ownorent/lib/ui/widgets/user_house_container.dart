import 'package:flutter/material.dart';

import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/ui/views/user_house_details_view.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/house_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/date.dart';
import '../../utils/font_size.dart';
import '../../utils/formatter.dart';

class UserhouseContainer extends StatefulWidget {
  House house;
  UserhouseContainer({super.key, required this.house});

  @override
  State<UserhouseContainer> createState() => _UserhouseContainerState();
}

class _UserhouseContainerState extends State<UserhouseContainer> {
  @override
  Widget build(BuildContext context) {
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    return GestureDetector(
        onTap: () {
          _houseViewmodel.setCurrentHouse(widget.house);
          RouteController().push(context, UserHouseDetails());
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 1.2,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: ownorentPurpleGrey),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                    child: Text(
                      'ADDED ${DateTimeFormatter().timeDifference(widget.house.dateAdded)} ago',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context),
                          color: ownorentWhite),
                    ),
                    margin: EdgeInsets.only(top: 10, left: 5),
                    height: 20,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 43, 110, 45),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(widget.house.images?[0]),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10, left: 4),
                child: Row(
                  children: [
                    Text(
                      '${getCurrency()}${formatMoney(int.parse(widget.house.price ?? ""))}',
                      style: TextStyle(
                          color: ownorentPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().h3(context)),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 4),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        '${widget.house.bedroomNumber} Beds',
                        style: TextStyle(
                            color: ownorentPurple,
                            fontSize: TextSize().p(context)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        '${widget.house.bathroomNumber} Baths',
                        style: TextStyle(
                            color: ownorentPurple,
                            fontSize: TextSize().p(context)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 4),
                child: Text(
                  widget.house.address ?? "",
                  style: TextStyle(
                    fontSize: TextSize().small(context),
                    color: ownorentPurple,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                child: Text(
                  "Added by You",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TextSize().small(context),
                      color: ownorentWhite),
                ),
                margin: EdgeInsets.only(top: 10, left: 5),
                height: 20,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(15)),
              ),
            ],
          ),
        ));
  }
}
