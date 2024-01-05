
import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';




// const String key = "7797XW76GKVKRG7AG67P9GMK3";
// const String key = "XKCNZRNRMCFAXW6JSVFA52K6W";
const String key = "4DLCXUEL7VD69K8R5FHAW4CEK";

class FetchData {
  WeatherData? wetherData;

  Future<WeatherData> processData(lat, log) async {
    final String url =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$log/last1days/next5days?unitGroup=metric&key=$key&contentType=json";

    Response response = await dio.get(url);
    wetherData = WeatherData.fromJson(response.data);

    return wetherData!;
  }
}
