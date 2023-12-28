import 'package:get/get.dart';

class Hour {
  RxString? datetime;
  RxDouble? temp;
  RxDouble? humidity;
  RxDouble? precipprob;
  RxDouble? snow;
  RxDouble? snowdepth;
  RxDouble? windgust;
  RxDouble? windspeed;
  RxDouble? pressure;
  RxDouble? visibility;
  RxDouble? cloudcover;
  RxString? conditions;
  RxString? icon;

  Hour({
    this.datetime,
    this.temp,
    this.humidity,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.windspeed,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.conditions,
    this.icon,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        datetime: (json['datetime'] as String).obs,
        temp: _roundTemperature(json['temp'] as double).obs,
        humidity: (json['humidity'] as double).obs,
        precipprob: (json['precipprob'] as double).obs,
        snow: (json['snow'] as double).obs,
        snowdepth: (json['snowdepth'] as double).obs,
        windgust: (json['windgust'] as double).obs,
        windspeed: (json['windspeed'] as double).obs,
        pressure: (json['pressure'] as double).obs,
        visibility: (json['visibility'] as double).obs,
        cloudcover: (json['cloudcover'] as double).obs,
        conditions: (json['conditions'] as String).obs,
        icon: (json['icon'] as String).obs,
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'temp': temp,
        'humidity': humidity,
        'precipprob': precipprob,
        'snow': snow,
        'snowdepth': snowdepth,
        'windgust': windgust,
        'windspeed': windspeed,
        'pressure': pressure,
        'visibility': visibility,
        'cloudcover': cloudcover,
        'conditions': conditions,
        'icon': icon,
      };

  static double _roundTemperature(double? temp) =>
      (temp != null && temp > 10) ? temp.roundToDouble() : temp ?? 0.0;
}
