import 'package:dio/dio.dart';
import 'package:weather_app/models/geonames.dart';

final dio = Dio();

class CityService {
  final String apiKey;

  CityService(this.apiKey);

  Future<List<Geoname>> searchCities(String query) async {
    const String apiUrl = 'http://api.geonames.org/searchJSON';
    // print('$apiUrl?q=$query&maxRows=20&username=$apiKey');

    final response =
        await dio.get('$apiUrl?q=$query&maxRows=20&username=$apiKey');

    if (response.statusCode == 200) {
      Geonames data = Geonames.fromJson(response.data);
      List<Geoname> filteredGeonames = data.geonames!
          .where((geoname) =>
              geoname.name != null &&
              geoname.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredGeonames.forEach((element) {
        print('=> ${element.name}');
      });

      return filteredGeonames;
    } else {
      throw Exception('Failed to load city data');
    }
  }


  Future<String> searchCitiesByLatLog(double lat, log) async {
      const String apiUrl = 'http://api.geonames.org/findNearbyJSON';
      final response =
          await dio.get('$apiUrl?lat=$lat&lng=$log&username=$apiKey');

      if (response.statusCode == 200) {
        Geonames data = Geonames.fromJson(response.data);

        return data.geonames![0].name!;
      } else {
        throw Exception('Failed to load city data');
      }
  }

}