import 'package:weather_app/api/apikey.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';

final dio = Dio();

class FetchData {
  WeatherData? wetherData;

  Future<WeatherData> processData(lat, log) async {
    final String url =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$log?unitGroup=metric&key=$key&contentType=json";

    Response response = await dio.get(url);
    print(response.data);
    wetherData = WeatherData.fromJson(response.data);

    return wetherData!;
  }
}
