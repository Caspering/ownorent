import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/appointment_viewmodel.dart';
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
    return Scaffold(
        // backgroundColor: Palette.grey.withOpacity(.05),
        appBar: AppBar(
          backgroundColor: ownorentWhite,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "Appointments",
            style: TextStyle(
                fontSize: TextSize().h2(context), color: ownorentPurple),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventsCalendar(onDateChanged: (date) {
                _appointmentViewmodel.selectCurrentDate(date);
                print(date);
              }),
              Text(
                "Upcoming Appointments",
                style: TextStyle(
                    color: ownorentPurple, fontSize: TextSize().h3(context)),
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile();
                      }))
            ],
          ),
        ));
  }
}
