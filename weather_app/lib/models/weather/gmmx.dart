class Gmmx {
  int? distance;
  double? latitude;
  double? longitude;
  int? useCount;
  String? id;
  String? name;
  int? quality;
  int? contribution;

  Gmmx({
    this.distance,
    this.latitude,
    this.longitude,
    this.useCount,
    this.id,
    this.name,
    this.quality,
    this.contribution,
  });

  @override
  String toString() {
    return 'Gmmx(distance: $distance, latitude: $latitude, longitude: $longitude, useCount: $useCount, id: $id, name: $name, quality: $quality, contribution: $contribution)';
  }

  factory Gmmx.fromJson(Map<String, dynamic> json) => Gmmx(
        distance: json['distance'] as int?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        useCount: json['useCount'] as int?,
        id: json['id'] as String?,
        name: json['name'] as String?,
        quality: json['quality'] as int?,
        contribution: json['contribution'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'latitude': latitude,
        'longitude': longitude,
        'useCount': useCount,
        'id': id,
        'name': name,
        'quality': quality,
        'contribution': contribution,
      };
}
