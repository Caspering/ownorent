import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ownorent/core/models/appointment_model.dart';
import 'package:ownorent/core/services/subcollection.dart';
import 'package:ownorent/utils/date.dart';

class AppointmentViewModel extends ChangeNotifier {
  DateTime _date = DateTime.now();
  get date => _date;
  TimeOfDay _time = TimeOfDay.now();
  get time => _time;
  setDate(d) {
    _date = d;
    notifyListeners();
  }

  setTime(t) {
    _time = t;
    notifyListeners();
  }

  String? _status;
  String? get status => _status;
  setStat(st) {
    _status = st;
    notifyListeners();
  }

  String _currentDate =
      DateTimeFormatter().displayDateWithMMM(DateTime.now()).trim();
  String get currentDate => _currentDate;
  selectCurrentDate(String sDate) {
    _currentDate = sDate.trim();
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _date) {
      setDate(picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      setTime(picked);
    }
  }

  Future createAppointment(Appointment data, uid, realtorId) {
    SubApi("appointments", "userAppointments", uid)
        .setData(data.toJson(), uid + realtorId);
    return SubApi("appointments", "userAppointments", realtorId)
        .setData(data.toJson(), uid + realtorId);
  }

  void acceptAppointment(realtorId, uid, appointmentId) {
    SubApi("appointments", "userAppointments", uid)
        .updateDocument('appointmentStatus', 'accepted😁', appointmentId);
    SubApi("appointments", "userAppointments", realtorId)
        .updateDocument('appointmentStatus', 'accepted😁', appointmentId);
  }

  void rejectAppointment(realtorId, uid, appointmentId) {
    SubApi("appointments", "userAppointments", uid)
        .updateDocument('appointmentStatus', 'rejected☹️', appointmentId);
    SubApi("appointments", "userAppointments", realtorId)
        .updateDocument('appointmentStatus', 'rejected☹️', appointmentId);
  }

  List<Appointment> userCalender = [];
  Future<List<Appointment>> getUserCalender(uid, date) async {
    var result = await SubApi("appointments", "userAppointments", uid)
        .getWhereIsEqualTo(date, "date");
    userCalender = result.docs
        .map((doc) =>
            Appointment.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return userCalender;
  }

  Appointment? _currentAppointment;
  Appointment? get currentAppointment => _currentAppointment;
  setCurrentAppointment(app) {
    _currentAppointment = app;
  }

  List<Appointment> _appointments = [];
  Map<DateTime, List<Appointment>> _appointmentsByDate = {};

  List<Appointment> get appointments => _appointments;

  Map<DateTime, List<Appointment>> get appointmentsByDate =>
      _appointmentsByDate;

  Future<List<Appointment>> loadAppointments(uid) async {
    QuerySnapshot querySnapshot =
        await SubApi("appointments", "userAppointments", uid).getDocuments();
    _appointments = querySnapshot.docs
        .map((doc) => Appointment()
          ..id = doc.id
          ..date = doc['date']
          ..time = doc['time']
          ..visitorsId = doc['visitorsId']
          ..visitorsName = doc['visitorsName']
          ..visitorsPicture = doc['visitorsPicture']
          ..appointmentStatus = doc['appointmentStatus']
          ..visitorsPhoneNumber = doc['visitorsPhoneNumber']
          ..agentId = doc['agentId']
          ..houseId = doc['houseId']
          ..houseAddress = doc['houseAddress']
          ..agentNumber = doc['agentNumber'])
        .toList();
    _appointmentsByDate = getAppointmentsByDate(_appointments);

    return _appointments;
  }

  Map<DateTime, List<Appointment>> getAppointmentsByDate(
      List<Appointment> appointments) {
    Map<DateTime, List<Appointment>> result = {};
    for (Appointment appointment in appointments) {
      DateTime date = DateTime.parse(
          DateTimeFormatter().convertDateFormat(appointment.date!));
      if (result[date] != null) {
        result[date]!.add(appointment);
      } else {
        result[date] = [appointment];
      }
    }
    return result;
  }
}
