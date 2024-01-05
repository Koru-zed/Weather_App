import 'package:weather_app/models/weather_data/hour.dart';

import 'day.dart';
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

  Future<WeatherData> processData(lat, log) async {
    // const String key = "7797XW76GKVKRG7AG67P9GMK3";
    // const String key = "XKCNZRNRMCFAXW6JSVFA52K6W";
    const String key = "4DLCXUEL7VD69K8R5FHAW4CEK";

    final String url =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$log/last1days/next5days?unitGroup=metric&key=$key&contentType=json";

    final response = await dio.get(url);

    return WeatherData.fromJson(response.data);
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


    void updateUnitsToUS(String unit) {
    days!.forEach((Day day) {
      day.tempmax!.value = celsiusToFahrenheit(day.tempmax!.value);
      day.tempmin!.value = celsiusToFahrenheit(day.tempmin!.value);
      day.hours!.forEach((Hour hour) {
        hour.temp!.value = celsiusToFahrenheit(hour.temp!.value);
        if (unit == 'UK') {
          hour.windspeed!.value = kilometersToMiles(hour.windspeed!.value);
        }
      });
    });
  }

  void updateUnitsToUk(String unit) {
    if (unit == 'Metric') {
      days!.forEach((Day day) {
        day.hours!.forEach((Hour hour) {
          hour.windspeed!.value = kilometersToMiles(hour.windspeed!.value);
        });
      });
    } else if (unit == 'US') {
      days!.forEach((Day day) {
        day.tempmax!.value = fahrenheitToCelsius(day.tempmax!.value);
        day.tempmin!.value = fahrenheitToCelsius(day.tempmin!.value);
        day.hours!.forEach((Hour hour) {
          hour.temp!.value = fahrenheitToCelsius(hour.temp!.value);
        });
      });
    }
  }

  void updateUnitsToMetric(String unit) {
    if (unit == 'US') {
      days!.forEach((Day day) {
        day.tempmax!.value = fahrenheitToCelsius(day.tempmax!.value);
        day.tempmin!.value = fahrenheitToCelsius(day.tempmin!.value);
        day.hours!.forEach((Hour hour) {
          hour.temp!.value = fahrenheitToCelsius(hour.temp!.value);
          hour.windspeed!.value = milesToKilometers(hour.windspeed!.value);
        });
      });
    } else if (unit == 'UK') {
      days!.forEach((Day day) {
        day.hours!.forEach((Hour hour) {
          hour.windspeed!.value = milesToKilometers(hour.windspeed!.value);
        });
      });
    }
  }

  void updateUnits(String unit, String state) {
    if (unit == 'Metric' && state != unit) updateUnitsToMetric(unit);
    if (unit == 'US' && state != unit) updateUnitsToUS(unit);
    if (unit == 'UK' && state != unit) updateUnitsToUk(unit);
  }
}
