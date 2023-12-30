
class Geonames {
  int? totalResultsCount;
  List<Geoname>? geonames;

  Geonames({this.totalResultsCount, this.geonames});

  factory Geonames.fromJson(Map<String, dynamic> json) => Geonames(
        totalResultsCount: json['totalResultsCount'] as int?,
        geonames: (json['geonames'] as List<dynamic>?)
            ?.map((e) => Geoname.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'totalResultsCount': totalResultsCount,
        'geonames': geonames?.map((e) => e.toJson()).toList(),
      };
}

class Geoname {
  double? lng;
  String? name;
  String? countryName;
  double? lat;

  Geoname({
    this.lng,
    this.name,
    this.countryName,
    this.lat,
  });

  factory Geoname.fromJson(Map<String, dynamic> json) => Geoname(
        lng: double.parse(json['lng']),
        name: json['name'] as String?,
        countryName: json['countryName'] as String?,
        lat: double.parse(json['lat']),
      );

  Map<String, dynamic> toJson() => {
        'lng': lng,
        'name': name,
        'countryName': countryName,
        'lat': lat,
      };
}

