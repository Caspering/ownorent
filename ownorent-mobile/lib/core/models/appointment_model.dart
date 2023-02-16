class Appointment {
  String? id;
  dynamic date;
  dynamic time;
  String? visitorsId;
  String? visitorsName;
  String? visitorsPicture;
  String? appointmentStatus; //postponed, accepted, rejected, completed
  String? visitorsPhoneNumber;
  String? houseId;
  String? houseAddress;
  String? agentNumber;
  Appointment(
      {this.id,
      this.appointmentStatus,
      this.visitorsPicture,
      this.date,
      this.visitorsId,
      this.visitorsName,
      this.houseId,
      this.visitorsPhoneNumber,
      this.time,
      this.houseAddress,
      this.agentNumber});
  Appointment.fromMap(Map<String, dynamic> snapshot, this.id)
      : date = snapshot['date'],
        time = snapshot['time'],
        visitorsId = snapshot['visitorsId'],
        visitorsName = snapshot['visitorsName'],
        visitorsPicture = snapshot['visitorsPicture'],
        houseId = snapshot['houseId'],
        visitorsPhoneNumber = snapshot['visitorsPhoneNumber'],
        agentNumber = snapshot['agentNumber'],
        houseAddress = snapshot['houseAddress'],
        appointmentStatus = snapshot['appointmentStatus'];

  toJson() {
    return {
      "date": date,
      "time": time,
      "visitorsId": visitorsId,
      "visitorsName": visitorsName,
      "visitorsPicture": visitorsPicture,
      "appointmentStatus": appointmentStatus,
      "houseId": houseId,
      "agentNumber": agentNumber,
      "houseAddress": houseAddress,
      "visitorsPhoneNumber": visitorsPhoneNumber
    };
  }
}
