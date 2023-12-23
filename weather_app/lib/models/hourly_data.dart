
class Hour {
  String? datetime;
  int? datetimeEpoch;
  int? temp;
  int? feelslike;
  double? humidity;
  int? dew;
  int? precip;
  int? precipprob;
  int? snow;
  int? snowdepth;
  dynamic preciptype;
  double? windgust;
  double? windspeed;
  double? winddir;
  int? pressure;
  int? visibility;
  int? cloudcover;
  int? solarradiation;
  int? solarenergy;
  int? uvindex;
  int? severerisk;
  String? conditions;
  String? icon;
  List<String>? stations;
  String? source;

  Hour({
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
    this.severerisk,
    this.conditions,
    this.icon,
    this.stations,
    this.source,
  });

  @override
  String toString() {
    return 'Hour(datetime: $datetime, datetimeEpoch: $datetimeEpoch, temp: $temp, feelslike: $feelslike, humidity: $humidity, dew: $dew, precip: $precip, precipprob: $precipprob, snow: $snow, snowdepth: $snowdepth, preciptype: $preciptype, windgust: $windgust, windspeed: $windspeed, winddir: $winddir, pressure: $pressure, visibility: $visibility, cloudcover: $cloudcover, solarradiation: $solarradiation, solarenergy: $solarenergy, uvindex: $uvindex, severerisk: $severerisk, conditions: $conditions, icon: $icon, stations: $stations, source: $source)';
  }

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        datetime: json['datetime'] as String?,
        datetimeEpoch: json['datetimeEpoch'] as int?,
        temp: json['temp'] as int?,
        feelslike: json['feelslike'] as int?,
        humidity: (json['humidity'] as num?)?.toDouble(),
        dew: json['dew'] as int?,
        precip: json['precip'] as int?,
        precipprob: json['precipprob'] as int?,
        snow: json['snow'] as int?,
        snowdepth: json['snowdepth'] as int?,
        preciptype: json['preciptype'] as dynamic,
        windgust: (json['windgust'] as num?)?.toDouble(),
        windspeed: (json['windspeed'] as num?)?.toDouble(),
        winddir: (json['winddir'] as num?)?.toDouble(),
        pressure: json['pressure'] as int?,
        visibility: json['visibility'] as int?,
        cloudcover: json['cloudcover'] as int?,
        solarradiation: json['solarradiation'] as int?,
        solarenergy: json['solarenergy'] as int?,
        uvindex: json['uvindex'] as int?,
        severerisk: json['severerisk'] as int?,
        conditions: json['conditions'] as String?,
        icon: json['icon'] as String?,
        stations: json['stations'] as List<String>?,
        source: json['source'] as String?,
      );

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
        'severerisk': severerisk,
        'conditions': conditions,
        'icon': icon,
        'stations': stations,
        'source': source,
      };
}
