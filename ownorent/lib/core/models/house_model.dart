class House {
  String? id;
  String? type; //rent, sale
  String? address;
  String? description;
  List? images; //list of urls
  String? videoTour; //url
  String? bedroomNumber;
  String? bathroomNumber;
  double? locationLat;
  double? locationLong;
  String? accomodationType; //bungalow, duplex, flat
  String? ownersId; //
  dynamic dateAdded;
  String? area;
  String? price;
  bool? isPromoted;
  House(
      {this.accomodationType,
      this.address,
      this.bathroomNumber,
      this.isPromoted,
      this.price,
      this.bedroomNumber,
      this.description,
      this.id,
      this.images,
      this.locationLat,
      this.locationLong,
      this.ownersId,
      this.type,
      this.videoTour,
      this.area,
      this.dateAdded});
  House.fromMap(Map snapshot, this.id)
      : accomodationType = snapshot['accomodationType'],
        address = snapshot['address'],
        bathroomNumber = snapshot['bathroomNumber'],
        bedroomNumber = snapshot['bedroomNumber'],
        dateAdded = snapshot['dateAdded'],
        area = snapshot['area'],
        description = snapshot['description'],
        images = snapshot['images'],
        price = snapshot['price'],
        locationLat = snapshot['locationLat'],
        locationLong = snapshot['locationLong'],
        ownersId = snapshot['ownersId'],
        type = snapshot['type'],
        isPromoted = snapshot['isPromoted'],
        videoTour = snapshot['videoTour'];

  toJson() {
    return {
      "accomodationType": accomodationType,
      "isPromoted": isPromoted,
      "address": address,
      "bedroomNumber": bedroomNumber,
      "bathroomNumber": bathroomNumber,
      "description": description,
      "images": images,
      "locationLat": locationLat,
      "locationLong": locationLong,
      "ownersId": ownersId,
      "type": type,
      "price": price,
      "videoTour": videoTour,
      "area": area,
      "dateAdded": dateAdded
    };
  }
}
