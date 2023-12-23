import 'current_conditions.dart';
import 'day.dart';
import 'stations.dart';

class Weather {
  int? queryCost;
  double? latitude;
  double? longitude;
  String? resolvedAddress;
  String? address;
  String? timezone;
  int? tzoffset;
  List<Day>? days;
  Stations? stations;
  CurrentConditions? currentConditions;

  Weather({
    this.queryCost,
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.tzoffset,
    this.days,
    this.stations,
    this.currentConditions,
  });

  @override
  String toString() {
    return 'Weather(queryCost: $queryCost, latitude: $latitude, longitude: $longitude, resolvedAddress: $resolvedAddress, address: $address, timezone: $timezone, tzoffset: $tzoffset, days: $days, stations: $stations, currentConditions: $currentConditions)';
  }

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        queryCost: json['queryCost'] as int?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        resolvedAddress: json['resolvedAddress'] as String?,
        address: json['address'] as String?,
        timezone: json['timezone'] as String?,
        tzoffset: json['tzoffset'] as int?,
        days: (json['days'] as List<dynamic>?)
            ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
            .toList(),
        stations: json['stations'] == null
            ? null
            : Stations.fromJson(json['stations'] as Map<String, dynamic>),
        currentConditions: json['currentConditions'] == null
            ? null
            : CurrentConditions.fromJson(
                json['currentConditions'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'queryCost': queryCost,
        'latitude': latitude,
        'longitude': longitude,
        'resolvedAddress': resolvedAddress,
        'address': address,
        'timezone': timezone,
        'tzoffset': tzoffset,
        'days': days?.map((e) => e.toJson()).toList(),
        'stations': stations?.toJson(),
        'currentConditions': currentConditions?.toJson(),
      };
}
