import 'gmmx.dart';

class Stations {
  Gmmx? gmmx;

  Stations({this.gmmx});

  @override
  String toString() => 'Stations(gmmx: $gmmx)';

  factory Stations.fromJson(Map<String, dynamic> json) => Stations(
        gmmx: json['GMMX'] == null
            ? null
            : Gmmx.fromJson(json['GMMX'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'GMMX': gmmx?.toJson(),
      };
}
