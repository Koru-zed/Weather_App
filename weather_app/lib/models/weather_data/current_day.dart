
class CurrentDay {
  String? datetime;
  double? temp;
  double? humidity;
  double? precipprob;
  double? snow;
  double? snowdepth;
  dynamic windgust;
  double? windspeed;
  double? pressure;
  double? visibility;
  double? cloudcover;
  String? conditions;
  String? icon;
  String? sunrise;
  String? sunset;
  double? moonphase;

  CurrentDay({
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
    this.sunrise,
    this.sunset,
    this.moonphase,
  });

  factory CurrentDay.fromJson(Map<String, dynamic> json) {
    return CurrentDay(
      datetime: json['datetime'] as String?,
      temp: json['temp'] as double?,
      humidity: json['humidity'] as double?,
      precipprob: json['precipprob'] as double?,
      snow: json['snow'] as double?,
      snowdepth: json['snowdepth'] as double?,
      windgust: json['windgust'] as dynamic,
      windspeed: json['windspeed'] as double?,
      pressure: json['pressure'] as double?,
      visibility: json['visibility'] as double?,
      cloudcover: json['cloudcover'] as double?,
      conditions: json['conditions'] as String?,
      icon: json['icon'] as String?,
      sunrise: json['sunrise'] as String?,
      sunset: json['sunset'] as String?,
      moonphase: json['moonphase'] as double?,
    );
  }

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
        'conditions': conditions,
        'icon': icon,
        'sunrise': sunrise,
        'sunset': sunset,
        'moonphase': moonphase,
      };

  static double _roundTemperature(double? temp) => (temp != null && temp > 10) ? temp.roundToDouble() : temp ?? 0.0; 
  
}
