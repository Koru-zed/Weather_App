class Hour {
  String? datetime;
  double? temp;
  double? humidity;
  double? precipprob;
  double? snow;
  double? snowdepth;
  double? windgust;
  double? windspeed;
  double? pressure;
  double? visibility;
  String? conditions;
  String? icon;

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
    this.conditions,
    this.icon,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        datetime: json['datetime'] as String?,
        temp: _roundTemperature(json['temp'] as double?) ,
        humidity: json['humidity'] as double?,
        precipprob: json['precipprob'] as double?,
        snow: json['snow'] as double?,
        snowdepth: json['snowdepth'] as double?,
        windgust: json['windgust'] as double?,
        windspeed: json['windspeed'] as double?,
        pressure: json['pressure'] as double?,
        visibility: json['visibility'] as double?,
        conditions: json['conditions'] as String?,
        icon: json['icon'] as String?,
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
        'conditions': conditions,
        'icon': icon,
      };
  
  static double _roundTemperature(double? temp) => (temp != null && temp > 10) ? temp.roundToDouble() : temp ?? 0.0; 

}
