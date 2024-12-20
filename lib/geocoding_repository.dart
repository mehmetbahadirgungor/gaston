import 'package:gaston/utils/constants/api_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeocodingRepository {
  static Future<Map<String, dynamic>> fetchGeocode(String address) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        return location;
      } else {
        throw "Unable to find location: ${data['status']}";
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }

  static LatLng locationToGeocode (Map<String, dynamic> location) => LatLng(location['lat'], location['lng']);
  
}