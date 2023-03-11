// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/appointment_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/house_owner_card.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    AppointmentViewModel _appointmentViewmodel =
        Provider.of<AppointmentViewModel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ownorentPurple,
          ),
        ),
        backgroundColor: ownorentWhite,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          _appointmentViewmodel.currentAppointment?.time ?? "",
          style: TextStyle(
              fontSize: TextSize().h3(context), color: ownorentPurple),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ownorentWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Tour Details",
                      style: TextStyle(
                          fontSize: TextSize().h3(context),
                          color: ownorentPurple,
                          fontWeight: FontWeight.w600),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Date:",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurple,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _appointmentViewmodel.currentAppointment?.date ?? "",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurpleGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Time:",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurple,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _appointmentViewmodel.currentAppointment?.time ?? "",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurpleGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Location:",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurple,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _appointmentViewmodel
                                .currentAppointment?.houseAddress ??
                            "",
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            color: ownorentPurpleGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ownorentWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                // ignore: unrelated_type_equality_checks
                child: HouseOwnerCard(
                  role: _appointmentViewmodel.currentAppointment?.agentId ==
                          _auth.user
                      ? "Visitor"
                      : "Home owner",
                  ownerId: _appointmentViewmodel
                              .currentAppointment?.visitorsId ==
                          _auth.user
                      ? _appointmentViewmodel.currentAppointment?.agentId ?? ""
                      : _appointmentViewmodel.currentAppointment?.visitorsId ??
                          "",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
