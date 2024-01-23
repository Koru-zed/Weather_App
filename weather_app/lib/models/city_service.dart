import 'package:dio/dio.dart';
import 'package:weather_app/models/geonames.dart';

final dio = Dio();

class CityService {
  final String apiKey;

  CityService(this.apiKey);

  Future<List<Geoname>> searchCities(String query) async {
    const String apiUrl = 'http://api.geonames.org/searchJSON';

    try {
      final response = await dio.get(
        '$apiUrl?q=$query&maxRows=20&username=$apiKey',
        options: Options(
          receiveTimeout: const Duration(seconds: 2),
          sendTimeout: const Duration(seconds: 2),
        ),
      );

      if (response.statusCode == 200) {
        Geonames data = Geonames.fromJson(response.data);
        List<Geoname> filteredGeonames = data.geonames!
            .where((geoname) =>
                geoname.name != null &&
                geoname.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return filteredGeonames;
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      return List<Geoname>.empty(); // Return an empty list or handle it accordingly
    }
  }

  Future<String> searchCitiesByLatLog(double lat, log) async {
    const String apiUrl = 'http://api.geonames.org/findNearbyJSON';

    try {
      final response = await dio.get(
        '$apiUrl?lat=$lat&lng=$log&username=$apiKey',
        options: Options(
          receiveTimeout: const Duration(seconds: 2),
          sendTimeout: const Duration(seconds: 2),
        ),
      );

      if (response.statusCode == 200) {
        Geonames data = Geonames.fromJson(response.data);
        return data.geonames![0].name![0].toUpperCase() +
            data.geonames![0].name!.substring(1);
      } else {
        return Future.error('Failed to load city data');
      }
    } catch (e) {
      return Future.error('Failed to load city data');
    }
  }
}
