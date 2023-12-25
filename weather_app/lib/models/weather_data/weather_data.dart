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
          : CurrentDay.fromJson(json['currentConditions'] as Map<String, dynamic>),
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

  double celsiusToFahrenheit(double? celsius) => double.parse(((celsius! * 9 / 5) + 32).toStringAsFixed(2));

  double fahrenheitToCelsius(double? fahrenheit) => double.parse(((5 / 9) * (fahrenheit! - 32)).toStringAsFixed(2));
  
  double kilometersToMiles(double? kilometers) => double.parse((kilometers! * 0.621371).toStringAsFixed(2));
  
  double milesToKilometers(double? miles) => double.parse((miles! / 0.621371).toStringAsFixed(2));

}
