import 'current_day.dart';
import 'day.dart';

class WeatherData {
  double? latitude;
  double? longitude;
  String? resolvedAddress;
  String? address;
  String? timezone;
  List<Day>? days;
  CurrentDay? current;

  WeatherData({
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.days,
    this.current,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        resolvedAddress: json['resolvedAddress'] as String?,
        address: json['address'] as String?,
        timezone: json['timezone'] as String?,
        days: (json['days'] as List<dynamic>?)
            ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
            .toList(),
        current: json['currentConditions'] == null
            ? null
            : CurrentDay.fromJson(
                json['currentConditions'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'resolvedAddress': resolvedAddress,
        'address': address,
        'timezone': timezone,
        'days': days?.map((e) => e.toJson()).toList(),
        'current': current?.toJson(),
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
