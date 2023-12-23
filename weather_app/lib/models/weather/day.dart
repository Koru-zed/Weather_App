import 'hour.dart';

class Day {
  String? datetime;
  int? datetimeEpoch;
  double? tempmax;
  double? tempmin;
  double? temp;
  double? feelslikemax;
  double? feelslikemin;
  double? feelslike;
  double? dew;
  double? humidity;
  double? precip;
  double? precipprob;
  double? precipcover;
  dynamic preciptype;
  int? snow;
  int? snowdepth;
  double? windgust;
  double? windspeed;
  double? winddir;
  double? pressure;
  double? cloudcover;
  double? visibility;
  double? solarradiation;
  double? solarenergy;
  int? uvindex;
  int? severerisk;
  String? sunrise;
  int? sunriseEpoch;
  String? sunset;
  int? sunsetEpoch;
  double? moonphase;
  String? conditions;
  String? description;
  String? icon;
  List<String>? stations;
  String? source;
  List<Hour>? hours;

  Day({
    this.datetime,
    this.datetimeEpoch,
    this.tempmax,
    this.tempmin,
    this.temp,
    this.feelslikemax,
    this.feelslikemin,
    this.feelslike,
    this.dew,
    this.humidity,
    this.precip,
    this.precipprob,
    this.precipcover,
    this.preciptype,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.windspeed,
    this.winddir,
    this.pressure,
    this.cloudcover,
    this.visibility,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
    this.conditions,
    this.description,
    this.icon,
    this.stations,
    this.source,
    this.hours,
  });

  @override
  String toString() {
    return 'Day(datetime: $datetime, datetimeEpoch: $datetimeEpoch, tempmax: $tempmax, tempmin: $tempmin, temp: $temp, feelslikemax: $feelslikemax, feelslikemin: $feelslikemin, feelslike: $feelslike, dew: $dew, humidity: $humidity, precip: $precip, precipprob: $precipprob, precipcover: $precipcover, preciptype: $preciptype, snow: $snow, snowdepth: $snowdepth, windgust: $windgust, windspeed: $windspeed, winddir: $winddir, pressure: $pressure, cloudcover: $cloudcover, visibility: $visibility, solarradiation: $solarradiation, solarenergy: $solarenergy, uvindex: $uvindex, severerisk: $severerisk, sunrise: $sunrise, sunriseEpoch: $sunriseEpoch, sunset: $sunset, sunsetEpoch: $sunsetEpoch, moonphase: $moonphase, conditions: $conditions, description: $description, icon: $icon, stations: $stations, source: $source, hours: $hours)';
  }

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        datetime: json['datetime'] as String?,
        datetimeEpoch: json['datetimeEpoch'] as int?,
        tempmax: (json['tempmax'] as num?)?.toDouble(),
        tempmin: (json['tempmin'] as num?)?.toDouble(),
        temp: (json['temp'] as num?)?.toDouble(),
        feelslikemax: (json['feelslikemax'] as num?)?.toDouble(),
        feelslikemin: (json['feelslikemin'] as num?)?.toDouble(),
        feelslike: (json['feelslike'] as num?)?.toDouble(),
        dew: (json['dew'] as num?)?.toDouble(),
        humidity: (json['humidity'] as num?)?.toDouble(),
        precip: (json['precip'] as num?)?.toDouble(),
        precipprob: (json['precipprob'] as num?)?.toDouble(),
        precipcover: (json['precipcover'] as num?)?.toDouble(),
        preciptype: json['preciptype'] as dynamic,
        snow: json['snow'] as int?,
        snowdepth: json['snowdepth'] as int?,
        windgust: (json['windgust'] as num?)?.toDouble(),
        windspeed: (json['windspeed'] as num?)?.toDouble(),
        winddir: (json['winddir'] as num?)?.toDouble(),
        pressure: (json['pressure'] as num?)?.toDouble(),
        cloudcover: (json['cloudcover'] as num?)?.toDouble(),
        visibility: (json['visibility'] as num?)?.toDouble(),
        solarradiation: (json['solarradiation'] as num?)?.toDouble(),
        solarenergy: (json['solarenergy'] as num?)?.toDouble(),
        uvindex: json['uvindex'] as int?,
        severerisk: json['severerisk'] as int?,
        sunrise: json['sunrise'] as String?,
        sunriseEpoch: json['sunriseEpoch'] as int?,
        sunset: json['sunset'] as String?,
        sunsetEpoch: json['sunsetEpoch'] as int?,
        moonphase: (json['moonphase'] as num?)?.toDouble(),
        conditions: json['conditions'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
        stations: json['stations'] as List<String>?,
        source: json['source'] as String?,
        hours: (json['hours'] as List<dynamic>?)
            ?.map((e) => Hour.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'datetimeEpoch': datetimeEpoch,
        'tempmax': tempmax,
        'tempmin': tempmin,
        'temp': temp,
        'feelslikemax': feelslikemax,
        'feelslikemin': feelslikemin,
        'feelslike': feelslike,
        'dew': dew,
        'humidity': humidity,
        'precip': precip,
        'precipprob': precipprob,
        'precipcover': precipcover,
        'preciptype': preciptype,
        'snow': snow,
        'snowdepth': snowdepth,
        'windgust': windgust,
        'windspeed': windspeed,
        'winddir': winddir,
        'pressure': pressure,
        'cloudcover': cloudcover,
        'visibility': visibility,
        'solarradiation': solarradiation,
        'solarenergy': solarenergy,
        'uvindex': uvindex,
        'severerisk': severerisk,
        'sunrise': sunrise,
        'sunriseEpoch': sunriseEpoch,
        'sunset': sunset,
        'sunsetEpoch': sunsetEpoch,
        'moonphase': moonphase,
        'conditions': conditions,
        'description': description,
        'icon': icon,
        'stations': stations,
        'source': source,
        'hours': hours?.map((e) => e.toJson()).toList(),
      };
}
