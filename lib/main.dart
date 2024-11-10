import 'package:flutter/material.dart';
import 'package:location/location.dart';

Future<LocationData?> _currentLocation() async {
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

class MapQuestStaticMap extends StatelessWidget {
  final String apiKey = 'jcOvjOSScAInBDkrNoNea3L4WX07iNGr';

  // Function to generate the static map image URL
  String getStaticMapUrl(double latitude, double longitude, {int zoom = 15, String size = '600,400'}) {
    final url = Uri.parse(
      'https://www.mapquestapi.com/staticmap/v5/map'
      '?key=$apiKey'
      '&center=$latitude,$longitude'
      '&size=$size'
      '&zoom=$zoom'
      '&locations=$latitude,$longitude'
    );
    return url.toString();
  }

  @override
  Widget build(BuildContext context) {
    double latitude = 40.748817; // Example coordinates (Empire State Building)
    double longitude = -73.985428;
    
    // Get the URL for the static map
    String staticMapUrl = getStaticMapUrl(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MapQuest Static Map'),
      ),
      body: Center(
        child: Image.network(staticMapUrl),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapQuestStaticMap(),
  ));
}