class CurrentConditions {
  String? datetime;
  int? datetimeEpoch;
  int? temp;
  int? feelslike;
  double? humidity;
  int? dew;
  dynamic precip;
  int? precipprob;
  int? snow;
  int? snowdepth;
  dynamic preciptype;
  dynamic windgust;
  double? windspeed;
  double? winddir;
  int? pressure;
  int? visibility;
  int? cloudcover;
  int? solarradiation;
  int? solarenergy;
  int? uvindex;
  String? conditions;
  String? icon;
  List<String>? stations;
  String? source;
  String? sunrise;
  int? sunriseEpoch;
  String? sunset;
  int? sunsetEpoch;
  double? moonphase;

  CurrentConditions({
    this.datetime,
    this.datetimeEpoch,
    this.temp,
    this.feelslike,
    this.humidity,
    this.dew,
    this.precip,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.preciptype,
    this.windgust,
    this.windspeed,
    this.winddir,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.conditions,
    this.icon,
    this.stations,
    this.source,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
  });

  @override
  String toString() {
    return 'CurrentConditions(datetime: $datetime, datetimeEpoch: $datetimeEpoch, temp: $temp, feelslike: $feelslike, humidity: $humidity, dew: $dew, precip: $precip, precipprob: $precipprob, snow: $snow, snowdepth: $snowdepth, preciptype: $preciptype, windgust: $windgust, windspeed: $windspeed, winddir: $winddir, pressure: $pressure, visibility: $visibility, cloudcover: $cloudcover, solarradiation: $solarradiation, solarenergy: $solarenergy, uvindex: $uvindex, conditions: $conditions, icon: $icon, stations: $stations, source: $source, sunrise: $sunrise, sunriseEpoch: $sunriseEpoch, sunset: $sunset, sunsetEpoch: $sunsetEpoch, moonphase: $moonphase)';
  }

  factory CurrentConditions.fromJson(Map<String, dynamic> json) {
    return CurrentConditions(
      datetime: json['datetime'] as String?,
      datetimeEpoch: json['datetimeEpoch'] as int?,
      temp: json['temp'] as int?,
      feelslike: json['feelslike'] as int?,
      humidity: (json['humidity'] as num?)?.toDouble(),
      dew: json['dew'] as int?,
      precip: json['precip'] as dynamic,
      precipprob: json['precipprob'] as int?,
      snow: json['snow'] as int?,
      snowdepth: json['snowdepth'] as int?,
      preciptype: json['preciptype'] as dynamic,
      windgust: json['windgust'] as dynamic,
      windspeed: (json['windspeed'] as num?)?.toDouble(),
      winddir: (json['winddir'] as num?)?.toDouble(),
      pressure: json['pressure'] as int?,
      visibility: json['visibility'] as int?,
      cloudcover: json['cloudcover'] as int?,
      solarradiation: json['solarradiation'] as int?,
      solarenergy: json['solarenergy'] as int?,
      uvindex: json['uvindex'] as int?,
      conditions: json['conditions'] as String?,
      icon: json['icon'] as String?,
      stations: json['stations'] as List<String>?,
      source: json['source'] as String?,
      sunrise: json['sunrise'] as String?,
      sunriseEpoch: json['sunriseEpoch'] as int?,
      sunset: json['sunset'] as String?,
      sunsetEpoch: json['sunsetEpoch'] as int?,
      moonphase: (json['moonphase'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'datetimeEpoch': datetimeEpoch,
        'temp': temp,
        'feelslike': feelslike,
        'humidity': humidity,
        'dew': dew,
        'precip': precip,
        'precipprob': precipprob,
        'snow': snow,
        'snowdepth': snowdepth,
        'preciptype': preciptype,
        'windgust': windgust,
        'windspeed': windspeed,
        'winddir': winddir,
        'pressure': pressure,
        'visibility': visibility,
        'cloudcover': cloudcover,
        'solarradiation': solarradiation,
        'solarenergy': solarenergy,
        'uvindex': uvindex,
        'conditions': conditions,
        'icon': icon,
        'stations': stations,
        'source': source,
        'sunrise': sunrise,
        'sunriseEpoch': sunriseEpoch,
        'sunset': sunset,
        'sunsetEpoch': sunsetEpoch,
        'moonphase': moonphase,
      };
}
