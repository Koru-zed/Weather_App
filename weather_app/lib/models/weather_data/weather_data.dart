import 'package:weather_app/models/fake_data.dart';
import 'package:weather_app/models/weather_data/hour.dart';
import 'day.dart';
// import 'package:weather_app/models/fake_data.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final dio = Dio();

class WeatherData {
  RxDouble? latitude;
  RxDouble? longitude;
  RxString? resolvedAddress;
  RxString? address;
  RxString? timezone;
  RxList<Day>? days;
  final List<List<String>> units = [
    ['C', 'km'],
    ['F', 'miles'],
    ['C', 'miles']
  ];

  WeatherData({
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.days,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        latitude: (json['latitude'] as double).obs,
        longitude: (json['longitude'] as double).obs,
        resolvedAddress: (json['resolvedAddress'] as String).obs,
        address: (json['address'] as String).obs,
        timezone: (json['timezone'] as String).obs,
        days: (json['days'] as List<dynamic>?)
            ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
            .toList()
            .obs,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'resolvedAddress': resolvedAddress,
        'address': address,
        'timezone': timezone,
        'days': days?.map((e) => e.toJson()).toList(),
      };

  Future<WeatherData> processData(lat, log, int k) async {
    List<String> keys = [
      "7797XW76GKVKRG7AG67P9GMK3",
      "XKCNZRNRMCFAXW6JSVFA52K6W",
      "4DLCXUEL7VD69K8R5FHAW4CEK"
    ];
    // return WeatherData.fromJson(fake_data);////////

    final String url =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$log/last1days/next5days?unitGroup=metric&key=${keys[k % 3]}&contentType=json";
    try {
      final response = await dio.get(url);
      return WeatherData.fromJson(response.data);
    } catch (err) {
      if (k == 3) return WeatherData.fromJson(fake_data);
      return processData(lat, log, k + 1);
    }
  }

  double celsiusToFahrenheit(double? celsius) {
    double fahrenheit = (celsius! * 9 / 5) + 32;

    return fahrenheit < 10
        ? double.parse(fahrenheit.toStringAsFixed(2))
        : double.parse(fahrenheit.toStringAsFixed(1));
  }

  double fahrenheitToCelsius(double? fahrenheit) {
    double celsius = (5 / 9) * (fahrenheit! - 32);

    return celsius < 10
        ? double.parse(celsius.toStringAsFixed(2))
        : double.parse(celsius.toStringAsFixed(1));
  }

  double kilometersToMiles(double? kilometers) {
    double miles = kilometers! * 0.621371;

    return miles < 10
        ? double.parse(miles.toStringAsFixed(2))
        : double.parse(miles.toStringAsFixed(1));
  }

  double milesToKilometers(double? miles) {
    double kilometeres = miles! / 0.621371;

    return kilometeres < 10
        ? double.parse(kilometeres.toStringAsFixed(2))
        : double.parse(kilometeres.toStringAsFixed(1));
  }

  void updateUnitsToUS(List<String> state) {
    days!.forEach((Day day) {
      day.tempmax!.value = celsiusToFahrenheit(day.tempmax!.value);
      day.tempmin!.value = celsiusToFahrenheit(day.tempmin!.value);
      day.hours!.forEach((Hour hour) {
        hour.temp!.value = celsiusToFahrenheit(hour.temp!.value);
        if (state == units[0]) {
          hour.windspeed!.value = kilometersToMiles(hour.windspeed!.value);
        }
      });
    });
  }

  void updateUnitsToUk(List<String> state) {
    if (state == units[0]) {
      days!.forEach((Day day) {
        day.hours!.forEach((Hour hour) {
          hour.windspeed!.value = kilometersToMiles(hour.windspeed!.value);
        });
      });
    } else if (state == units[1]) {
      days!.forEach((Day day) {
        day.tempmax!.value = fahrenheitToCelsius(day.tempmax!.value);
        day.tempmin!.value = fahrenheitToCelsius(day.tempmin!.value);
        day.hours!.forEach((Hour hour) {
          hour.temp!.value = fahrenheitToCelsius(hour.temp!.value);
        });
      });
    }
  }

  void updateUnitsToMetric(List<String> state) {
    if (state == units[1]) {
      days!.forEach((Day day) {
        day.tempmax!.value = fahrenheitToCelsius(day.tempmax!.value);
        day.tempmin!.value = fahrenheitToCelsius(day.tempmin!.value);
        day.hours!.forEach((Hour hour) {
          hour.temp!.value = fahrenheitToCelsius(hour.temp!.value);
          hour.windspeed!.value = milesToKilometers(hour.windspeed!.value);
        });
      });
    } else if (state == units[2]) {
      days!.forEach((Day day) {
        day.hours!.forEach((Hour hour) {
          hour.windspeed!.value = milesToKilometers(hour.windspeed!.value);
        });
      });
    }
  }

  void updateUnits(List<String> unit, List<String> state) {
    
    if (unit == units[0] && state != unit) updateUnitsToMetric(state);
    if (unit == units[1] && state != unit) updateUnitsToUS(state);
    if (unit == units[2] && state != unit) updateUnitsToUk(state);
  }
}
