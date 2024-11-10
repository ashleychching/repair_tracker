import 'package:http/http.dart' as http;
import 'dart:convert';

class GeocodingService {
  final String apiKey = 'jcOvjOSScAInBDkrNoNea3L4WX07iNGr'; // Replace with your API key

  Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    final url = Uri.parse(
      'https://www.mapquestapi.com/geocoding/v1/address?key=$apiKey&location=${Uri.encodeComponent(address)}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract the latitude and longitude from the API response
        final latLng = data['results'][0]['locations'][0]['latLng'];
        final latitude = latLng['lat'] as double;
        final longitude = latLng['lng'] as double;

        return {'latitude': latitude, 'longitude': longitude};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
