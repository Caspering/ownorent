import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/core/models/appointment_model.dart';
import 'package:ownorent/core/viewmodels/appointment_viewmodel.dart';
import 'package:ownorent/utils/date.dart';
import 'package:ownorent/utils/popup.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTimeFormatter _timeFormatter = DateTimeFormatter();
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);
    AppointmentViewModel _appointmentViewmodel =
        Provider.of<AppointmentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
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
          'Book an appointment',
          style: TextStyle(
              color: ownorentPurple,
              fontSize: TextSize().p(context),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: ownorentWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date",
              style: TextStyle(
                  fontSize: TextSize().h3(context),
                  fontWeight: FontWeight.w600,
                  color: ownorentPurple),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    _timeFormatter
                        .displayDateWithMMM(_appointmentViewmodel.date),
                    style: TextStyle(
                        fontSize: TextSize().h2(context),
                        fontWeight: FontWeight.w700,
                        color: ownorentPurple),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {
                        _appointmentViewmodel.selectDate(context);
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: ownorentPurple,
                      ))
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Text(
              "Time",
              style: TextStyle(
                  fontSize: TextSize().h3(context),
                  fontWeight: FontWeight.w600,
                  color: ownorentPurple),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    _timeFormatter.displayTimeI(
                        _appointmentViewmodel.time, context),
                    style: TextStyle(
                        fontSize: TextSize().h2(context),
                        fontWeight: FontWeight.w700,
                        color: ownorentPurple),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {
                        _appointmentViewmodel.selectTime(context);
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: ownorentPurple,
                      ))
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            Text(
              "Location",
              style: TextStyle(
                  fontSize: TextSize().h3(context),
                  fontWeight: FontWeight.w600,
                  color: ownorentPurple),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.all(5),

              child: Text(
                _houseViewmodel.currentHouse?.address ?? "",
                style: TextStyle(
                    fontSize: TextSize().h2(context),
                    fontWeight: FontWeight.w700,
                    color: ownorentPurple),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 60,
                width: MediaQuery.of(context).size.width / 1.5,
                child: MaterialButton(
                    onPressed: () async {
                      PopUp().popLoad(context);
                      var result = await _userViewModel
                          .getUserById(_houseViewmodel.currentHouse?.ownersId);
                      await _appointmentViewmodel.createAppointment(
                          Appointment(
                              appointmentStatus: "pending",
                              visitorsPicture:
                                  _userViewModel.currentUser?.profilePhoto,
                              date: DateTimeFormatter().displayDateWithMMM(
                                  _appointmentViewmodel.date),
                              time: _appointmentViewmodel.time.format(context),
                              visitorsId: _auth.userId,
                              visitorsName:
                                  _userViewModel.currentUser?.firstname,
                              houseId: _houseViewmodel.currentHouse?.id,
                              visitorsPhoneNumber:
                                  _userViewModel.currentUser?.phoneNumber,
                              houseAddress:
                                  _houseViewmodel.currentHouse?.address,
                              agentId: result?.id,
                              agentNumber: result?.phoneNumber),
                          _auth.userId,
                          _houseViewmodel.currentHouse?.ownersId);
                      RouteController().pop(context);
                      PopUp().showSuccess(
                          context, "House tour booked successfully");
                      //RouteController().push(context, BookAppointment());
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Book appointment",
                      style: TextStyle(
                          fontSize: TextSize().h3(context),
                          color: ownorentWhite),
                    )),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    color: ownorentPurple,
                    borderRadius: BorderRadius.circular(10)
                    //
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
