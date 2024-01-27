import 'package:get/get.dart';

class Hour {
  RxString? datetime;
  RxDouble? temp;
  RxDouble? humidity; //
  RxDouble? precipprob;
  RxDouble? snow;
  RxDouble? snowdepth;
  RxDouble? solarradiation;
  RxDouble? solarenergy;
  RxDouble? winddir;
  RxDouble? windspeed; //
  RxDouble? visibility;
  RxDouble? cloudcover; //
  RxString? conditions;
  RxString? icon;

  Hour({
    this.datetime,
    this.temp,
    this.humidity,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.solarradiation,
    this.solarenergy,
    this.winddir,
    this.windspeed,
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
        solarradiation: (json['solarradiation'] as double).obs,
        solarenergy: (json['solarenergy'] as double).obs,
        winddir: (json['winddir'] as double).obs,
        windspeed: (json['windspeed'] as double).obs,
        visibility: (json['visibility'] as double).obs,
        cloudcover: (json['cloudcover'] as double).obs,
        conditions: (json['conditions'] as String).obs,
        icon: (json['icon'] as String).obs,
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime!.value,
        'temp': temp!.value,
        'humidity': humidity!.value,
        'precipprob': precipprob!.value,
        'snow': snow!.value,
        'snowdepth': snowdepth!.value,
        'solarradiation': solarradiation!.value,
        'solarenergy': solarenergy!.value,
        'winddir': winddir!.value,
        'windspeed': windspeed!.value,
        'visibility': visibility!.value,
        'cloudcover': cloudcover!.value,
        'conditions': conditions!.value,
        'icon': icon!.value,
      };

  static double _roundTemperature(double? temp) =>
      (temp != null && temp > 10) ? temp.roundToDouble() : temp ?? 0.0;
}
