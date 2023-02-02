class House {
  String? id;
  String? type; //rent, sale
  String? address;
  String? description;
  List<String>? images; //list of urls
  String? videoTour; //url
  String? bedroomNumber;
  String? bathroomNumber;
  double? locationLat;
  double? locationLong;
  String? accomodationType; //bungalow, duplex, flat
  String? ownersId; //
  House(
      {this.accomodationType,
      this.address,
      this.bathroomNumber,
      this.bedroomNumber,
      this.description,
      this.id,
      this.images,
      this.locationLat,
      this.locationLong,
      this.ownersId,
      this.type,
      this.videoTour});
  House.fromMap(Map<String, dynamic> snapshot, this.id)
      : accomodationType = snapshot['accomodationType'],
        address = snapshot['address'],
        bathroomNumber = snapshot['bathroomNumber'],
        bedroomNumber = snapshot['bedroomNumber'],
        description = snapshot['description'],
        images = snapshot['images'],
        locationLat = snapshot['locationLat'],
        locationLong = snapshot['locationLong'],
        ownersId = snapshot['ownersId'],
        type = snapshot['type'],
        videoTour = snapshot['videoTour'];

  toJson() {
    return {
      "accomodationType": accomodationType,
      "address": address,
      "bedroomNumber": bedroomNumber,
      "bathroomNumber": bathroomNumber,
      "description": description,
      "images": images,
      "locationLat": locationLat,
      "locationLong": locationLong,
      "ownersId": ownersId,
      "type": type,
      "videoTour": videoTour
    };
  }
}
