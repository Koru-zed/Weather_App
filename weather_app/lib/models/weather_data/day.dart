import 'dart:ffi';

import 'hour.dart';

class Day {
  String? datetime;
  double? tempmax;
  double? tempmin;
  double? temp;
  double? humidity;
  double? precipprob;
  double? snow;
  double? snowdepth;
  double? windgust;
  double? windspeed;
  double? pressure;
  double? visibility;
  String? sunrise;
  String? sunset;
  double? moonphase;
  String? conditions;
  String? description;
  String? icon;

  Day({
    this.datetime,
    this.tempmax,
    this.tempmin,
    this.temp,
    this.humidity,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.windspeed,
    this.pressure,
    this.visibility,
    this.sunrise,
    this.sunset,
    this.moonphase,
    this.conditions,
    this.description,
    this.icon,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        datetime: json['datetime'] as String?,
        tempmax: _roundTemperature(json['tempmax'] as double?),
        tempmin: _roundTemperature(json['tempmin'] as double?),
        temp: _roundTemperature(json['temp'] as double?),
        humidity: json['humidity'] as double?,
        precipprob: json['precipprob'] as double?,
        snow: json['snow'] as double?,
        snowdepth: json['snowdepth'] as double?,
        windgust: json['windgust'] as double?,
        windspeed: json['windspeed'] as double?,
        pressure: json['pressure'] as double?,
        visibility: json['visibility'] as double?,
        sunrise: json['sunrise'] as String?,
        sunset: json['sunset'] as String?,
        moonphase: json['moonphase'] as double?,
        conditions: json['conditions'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'tempmax': tempmax,
        'tempmin': tempmin,
        'temp': temp,
        'humidity': humidity,
        'precipprob': precipprob,
        'snow': snow,
        'snowdepth': snowdepth,
        'windgust': windgust,
        'windspeed': windspeed,
        'pressure': pressure,
        'visibility': visibility,
        'sunrise': sunrise,
        'sunset': sunset,
        'moonphase': moonphase,
        'conditions': conditions,
        'description': description,
        'icon': icon,
      };
  
  static double _roundTemperature(double? temp) => (temp != null && temp > 10) ? temp.roundToDouble() : temp ?? 0.0; 
  
}
