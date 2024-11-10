import 'package:flutter/material.dart';

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