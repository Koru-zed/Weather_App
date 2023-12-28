import 'package:get/get.dart';
import 'hour.dart';

class Day {
  RxString? datetime;
  RxDouble? tempmax;
  RxDouble? tempmin;
  RxDouble? temp;
  RxDouble? humidity;
  RxDouble? precipprob;
  RxDouble? snow;
  RxDouble? snowdepth;
  RxDouble? windgust;
  RxDouble? windspeed;
  RxDouble? pressure;
  RxDouble? visibility;
  RxString? sunrise;
  RxString? sunset;
  RxDouble? moonphase;
  RxString? conditions;
  RxString? description;
  RxString? icon;
  RxList<Hour>? hours;

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
    this.hours,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        datetime: (json['datetime'] as String).obs,
        tempmax: _roundTemperature((json['tempmax'] as double).obs),
        tempmin: _roundTemperature((json['tempmin'] as double).obs),
        temp: _roundTemperature((json['temp'] as double).obs),
        humidity: (json['humidity'] as double).obs,
        precipprob: (json['precipprob'] as double).obs,
        snow: (json['snow'] as double).obs,
        snowdepth: (json['snowdepth'] as double).obs,
        windgust: (json['windgust'] as double).obs,
        windspeed: (json['windspeed'] as double).obs,
        pressure: (json['pressure'] as double).obs,
        visibility: (json['visibility'] as double).obs,
        sunrise: ((json['sunrise'] as String).substring(0, 5)).obs,
        sunset: ((json['sunset'] as String).substring(0, 5)).obs,
        moonphase: (json['moonphase'] as double).obs,
        conditions: (json['conditions'] as String).obs,
        description: (json['description'] as String).obs,
        icon: (json['icon'] as String).obs,
        hours: (json['hours'] as List<dynamic>?)
            ?.map((e) => Hour.fromJson(e as Map<String, dynamic>))
            .toList()
            .obs,
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime?.value,
        'tempmax': tempmax?.value,
        'tempmin': tempmin?.value,
        'temp': temp?.value,
        'humidity': humidity?.value,
        'precipprob': precipprob?.value,
        'snow': snow?.value,
        'snowdepth': snowdepth?.value,
        'windgust': windgust?.value,
        'windspeed': windspeed?.value,
        'pressure': pressure?.value,
        'visibility': visibility?.value,
        'sunrise': sunrise?.value,
        'sunset': sunset?.value,
        'moonphase': moonphase?.value,
        'conditions': conditions?.value,
        'description': description?.value,
        'icon': icon?.value,
        'hours': hours?.map((e) => e.toJson()).toList(),
      };

  static RxDouble? _roundTemperature(RxDouble? temp) =>
      (temp != null && temp.value > 10)
          ? RxDouble(temp.value.roundToDouble())
          : temp ?? RxDouble(0.0);
}
