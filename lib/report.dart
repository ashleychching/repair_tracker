import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

const String apiKey = 'jcOvjOSScAInBDkrNoNea3L4WX07iNGr';

Future<LocationData?> getCurrentLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
 
  Location location = Location();
 
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }
 
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  return await location.getLocation();
}

Future<LatLng?> getCoordinatesFromAddress(String address) async {
  final url = Uri.parse('https://www.mapquestapi.com/geocoding/v1/address?key=$apiKey&location=${Uri.encodeComponent(address)}',);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Extract the latitude and longitude from the API response
      final latLng = data['results'][0]['locations'][0]['latLng'];
      final latitude = latLng['lat'] as double;
      final longitude = latLng['lng'] as double;

      return LatLng(latitude, longitude);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    final String url = 'https://www.mapquestapi.com/geocoding/v1/reverse?key=$apiKey&location=$latitude,$longitude';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Extract the address from the response
        final address = data['results'][0]['locations'][0]['street'];
        final city = data['results'][0]['locations'][0]['adminArea5'];
        final state = data['results'][0]['locations'][0]['adminArea3'];
        final postalCode = data['results'][0]['locations'][0]['postalCode'];

        // Return the full address
        return '$address, $city, $state, $postalCode';
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
// Function to get the latitude and longitude from an address as an Array
Future<List<double>?> getLatLongFromAddress(String address) async {
  final String apiUrl = 'http://www.mapquestapi.com/geocoding/v1/address?key=$apiKey&location=$address';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Check if results exist
      if (data['results'].isNotEmpty) {
        // Get latitude and longitude from the first result
        var latLng = data['results'][0]['locations'][0]['latLng'];
        double latitude = latLng['lat'];
        double longitude = latLng['lng'];

        return [latitude, longitude]; // Return as List<double>
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

class Report {
  String? title;
  String? description;

  String? address;
  double? latitude;
  double? longitude;

  List<String>? images;

  Report (this.title, this.description, this.address, this.latitude, this.longitude, this.images);

  String getStaticMapUrl({int height = 400, int width = 400}){
    final url = Uri.parse(
      'https://www.mapquestapi.com/staticmap/v5/map'
      '?key=$apiKey'
      '&center=$latitude,$longitude'
      '&size=$height,$width'
      '&zoom=17'
      '&markers=$latitude,$longitude'
    );
    return url.toString();
  }

}