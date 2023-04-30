import 'package:flutter/material.dart';
import 'package:ownorent/core/models/appointment_model.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:ownorent/utils/font_size.dart';
import 'package:ownorent/utils/string_manip.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../core/viewmodels/appointment_viewmodel.dart';
import '../../utils/date_constants.dart';

class EventsCalendar extends StatefulWidget {
  final bool singleLine;
  final Function(DateTime) onDateChanged;

  const EventsCalendar({
    Key? key,
    required this.onDateChanged,
    this.singleLine = false,
  }) : super(key: key);

  @override
  _EventsCalendarState createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  late DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    updatedDate(_focusedDay);
  }

  @override
  void updatedDate(DateTime selectedDay) {
    _selectedDay = selectedDay;
    _currentDate = getCurrentDate();
    setState(() {});
  }

  String getCurrentDate() {
    return "${getMonth(_selectedDay.month)} ${_selectedDay.day}, ${_selectedDay.year}"
        .capitalizeFirstofEach;
  }

  String getDay(int day) {
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Sunday";
    }
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      default:
        return "December";
    }
  }

  @override
  Widget build(BuildContext context) {
    var unselectedDecoration = const BoxDecoration(
      color: Colors.transparent,
    );
    AppointmentViewModel _appointmentViewmodel =
        Provider.of<AppointmentViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: ownorentWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TableCalendar(
            daysOfWeekHeight: 16,
            calendarFormat: CalendarFormat.month,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500,
              ),
              weekendStyle: TextStyle(
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w400,
              ),
              weekendTextStyle: TextStyle(
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w400,
              ),
              defaultTextStyle: TextStyle(
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w400,
              ),
              weekendDecoration: unselectedDecoration,
              todayDecoration: unselectedDecoration,
              selectedDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ownorentPurple,
              ),
              defaultDecoration: unselectedDecoration,
              outsideDecoration: unselectedDecoration,
            ),
            // onCalendarCreated: (_) => widget.onDateChanged(_focusedDay),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                updatedDate(_selectedDay);
                widget.onDateChanged(_selectedDay);
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            headerVisible: true,
            headerStyle: const HeaderStyle(
                leftChevronMargin: EdgeInsets.all(0),
                rightChevronMargin: EdgeInsets.all(0),
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: ownorentPurpleGrey,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: ownorentPurpleGrey,
                )),

            firstDay: kFirstDate,
            focusedDay: _focusedDay,
            lastDay: kLastDate,
            startingDayOfWeek: StartingDayOfWeek.sunday,
          ),
        ),
      ],
    );
  }
}
