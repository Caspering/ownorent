import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ownorent/core/models/appointment_model.dart';
import 'package:ownorent/core/services/subcollection.dart';

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

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  selectCurrentDate(sDate) {
    _selectedDate = sDate;
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

  List<Appointment> userCalender = [];
  Future<List<Appointment>> getUserCalender(uid, date) async {
    var result = await SubApi("appointments", "userAppointments", uid)
        .getWhereIsEqualTo("date", date);
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
}
