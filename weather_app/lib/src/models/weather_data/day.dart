import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'hour.dart';

class Day {
  RxString? datetime;
  RxString? nameday;
  RxDouble? tempmax;//
  RxDouble? tempmin;//
  RxDouble? temp;
  RxString? sunrise;
  RxString? sunset;
  RxDouble? moonphase;
  RxString? conditions;
  RxString? description;
  RxString? icon;
  RxList<Hour>? hours;

  Day({
    this.datetime,
    this.nameday,
    this.tempmax,
    this.tempmin,
    this.temp,
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
        nameday: DateFormat('EEEE')
            .format(DateTime.parse(json['datetime'] as String))
            .obs,
        tempmax: _roundTemperature((json['tempmax'] as double).obs),
        tempmin: _roundTemperature((json['tempmin'] as double).obs),
        temp: _roundTemperature((json['temp'] as double).obs),
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
