// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/ui/views/singin.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:ownorent/utils/formatter.dart';
import 'package:ownorent/utils/router.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/favorite_viewmodel.dart';
import '../../utils/date.dart';

class FeedContainer extends StatefulWidget {
  final String mainImage;
  dynamic dateAdded;
  String price;
  String bedroom;
  String bathroom;
  String address;
  bool isPromoted;
  String type;
  String docId;
  Function() onTapped;
  FeedContainer(
      {super.key,
      required this.address,
      required this.docId,
      required this.isPromoted,
      required this.type,
      required this.bathroom,
      required this.bedroom,
      required this.price,
      required this.mainImage,
      required this.dateAdded,
      required this.onTapped});

  @override
  State<FeedContainer> createState() => _FeedContainerState();
}

class _FeedContainerState extends State<FeedContainer> {
  @override
  Widget build(BuildContext context) {
    FavoriteViewModel _favorites = Provider.of<FavoriteViewModel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return GestureDetector(
        onTap: widget.onTapped,
        child: Container(
          height: MediaQuery.of(context).size.height / 2.4,
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
                      'ADDED ${DateTimeFormatter().timeDifference(widget.dateAdded)} ago',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context),
                          color: ownorentWhite),
                    ),
                    margin: EdgeInsets.only(top: 10, left: 5),
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
                        image: NetworkImage(widget.mainImage),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10, left: 4),
                child: Row(
                  children: [
                    Text(
                      widget.type == "shortlet"
                          ? '${getCurrency()}${formatMoney(int.parse(widget.price))}/night'
                          : '${getCurrency()}${formatMoney(int.parse(widget.price))}',
                      style: TextStyle(
                          color: ownorentPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().h3(context)),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          if (_auth.authState == true) {
                            _favorites.addOrRemove(widget.docId);
                          } else {
                            RouteController().push(context, Login());
                          }
                        },
                        icon: Icon(
                          _favorites.favoriteIds!.contains(widget.docId)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: _favorites.favoriteIds!.contains(widget.docId)
                              ? ownorentRed
                              : ownorentPurple,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 4),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        '${widget.bedroom} Beds',
                        style: TextStyle(
                            color: ownorentPurple,
                            fontSize: TextSize().p(context)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        '${widget.bathroom} Baths',
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
                  widget.address,
                  style: TextStyle(
                    fontSize: TextSize().small(context),
                    color: ownorentPurple,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                child: Text(
                  widget.isPromoted == false ? 'Recommended' : "Sponsored",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TextSize().small(context),
                      color: ownorentWhite),
                ),
                margin: EdgeInsets.only(top: 10, left: 5),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(15)),
              ),
            ],
          ),
        ));
  }
}
