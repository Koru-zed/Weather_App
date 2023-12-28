
import 'day.dart';
import 'package:get/get.dart';

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
            .toList().obs,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'resolvedAddress': resolvedAddress,
        'address': address,
        'timezone': timezone,
        'days': days?.map((e) => e.toJson()).toList(),
      };

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
}
