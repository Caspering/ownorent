import 'package:flutter/foundation.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapMarkerConverter {
  static Future<BitmapDescriptor> convertImageToMarkerFromUrl(String imageUrl,
      {int width = 48, int height = 48}) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;

      BitmapDescriptor customMarker = BitmapDescriptor.fromBytes(bytes);

      return customMarker;
    } else {
      print("Error downloading marker image: ${response.statusCode}");
      throw Exception("Something went wrong");
    }
  }
}
