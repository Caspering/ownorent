import 'package:flutter/material.dart';
import 'package:ownorent/core/models/user_model.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/user_viewmodel.dart';

class UserRowWidget extends StatefulWidget {
  const UserRowWidget({super.key});

  @override
  State<UserRowWidget> createState() => _UserRowWidgetState();
}

class _UserRowWidgetState extends State<UserRowWidget> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewmodel>(context);
    return FutureBuilder<List<Users?>>(
        future: userViewModel.getFeedUsers(),
        builder: (context, snapshot) {
          print(snapshot.error);
          print(snapshot.data);
          if (snapshot.hasData) {
            print(snapshot.data);
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ownorentPurpleGrey)),
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width / 2.6,
                      );
                    }));
          } else {
            return Container();
          }
        });
  }
}
