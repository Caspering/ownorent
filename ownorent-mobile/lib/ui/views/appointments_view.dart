import 'package:flutter/material.dart';
import 'package:ownorent/core/models/appointment_model.dart';
import 'package:ownorent/ui/views/appointment_details_view.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/appointment_viewmodel.dart';
import '../../utils/date.dart';
import '../../utils/router.dart';
import '../shared/calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    AppointmentViewModel _appointmentViewmodel =
        Provider.of<AppointmentViewModel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
        // backgroundColor: Palette.grey.withOpacity(.05),
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
            "Appointments",
            style: TextStyle(
                fontSize: TextSize().h3(context), color: ownorentPurple),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventsCalendar(onDateChanged: (date) {
                _appointmentViewmodel.selectCurrentDate(
                    DateTimeFormatter().displayDateWithMMM(date));
                print(_appointmentViewmodel.currentDate);
              }),
              Text(
                "Upcoming Appointments",
                style: TextStyle(
                    color: ownorentPurple, fontSize: TextSize().h3(context)),
              ),
              Expanded(
                  child: FutureBuilder<List<Appointment>>(
                      future: _appointmentViewmodel.getUserCalender(
                          _auth.userId, _appointmentViewmodel.currentDate),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "No upcoming appointment",
                                style: TextStyle(
                                    fontSize: TextSize().h3(context),
                                    color: ownorentPurple),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: ownorentWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        onTap: () {
                                          _appointmentViewmodel
                                              .setCurrentAppointment(
                                                  snapshot.data?[index]);
                                          RouteController().push(
                                              context, AppointmentDetails());
                                        },
                                        title: Text(
                                          snapshot.data?[index].time ?? "",
                                          style: TextStyle(
                                              fontSize: TextSize().p(context),
                                              color: ownorentPurpleGrey),
                                        ),
                                        subtitle: Text(
                                          snapshot.data?[index].houseAddress ??
                                              "",
                                          style: TextStyle(
                                              fontSize: TextSize().h3(context),
                                              color: ownorentPurple),
                                        ),
                                        /*   trailing: Icon(
                                          snapshot.data?[index]
                                                      .appointmentStatus ==
                                                  "pending"
                                              ? Icons.pending
                                              : snapshot.data?[index]
                                                          .appointmentStatus ==
                                                      "accepted"
                                                  ? Icons.check
                                                  : Icons.dangerous,
                                          color: snapshot.data?[index]
                                                      .appointmentStatus ==
                                                  "pending"
                                              ? grey
                                              : snapshot.data?[index]
                                                          .appointmentStatus ==
                                                      "accepted"
                                                  ? Colors.green
                                                  : ownorentRed,
                                        ),*/
                                      ));
                                });
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ownorentPurple,
                            ),
                          );
                        }
                      }))
            ],
          ),
        ));
  }
}
