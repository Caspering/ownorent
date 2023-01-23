class Users {
  String? id;
  String? email;
  String? phoneNumber;
  double? lat;
  double? long;
  String? address;
  String? firstname;
  String? lastname;
  String? profilePhoto;
  bool? isVerified;

  Users(
      {this.address,
      this.id,
      this.email,
      this.firstname,
      this.lastname,
      this.lat,
      this.long,
      this.isVerified,
      this.profilePhoto,
      this.phoneNumber});
  Users.fromMap(Map<String, dynamic> snapshot, this.id)
      : address = snapshot['address'],
        email = snapshot['email'],
        firstname = snapshot['firstname'],
        lastname = snapshot['lastname'],
        lat = snapshot['lat'],
        long = snapshot['long'],
        profilePhoto = snapshot['profilePhoto'],
        isVerified = snapshot['isVerified'],
        phoneNumber = snapshot['phoneNumber'];
  toJson() {
    return {
      "address": address,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "lat": lat,
      "long": long,
      "phoneNumber": phoneNumber,
      "isVerified": isVerified,
      "profilePhoto": profilePhoto
    };
  }
}
