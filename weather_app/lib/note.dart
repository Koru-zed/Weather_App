// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/geonames/geoname.dart';
// import 'package:dio/dio.dart';

// final dio = Dio();

// class CityService {
//   final String apiKey;
//   final String apiUrl = 'http://api.geonames.org/searchJSON';

//   CityService(this.apiKey);

//   Future<List<Geoname>> searchCities(String query) async {
//     print('$apiUrl?q=$query&maxRows=20&username=$apiKey');
//     Response response =
//         await dio.get('$apiUrl?q=$query&maxRows=20&username=$apiKey');

//     if (response.statusCode == 200) {
//       Geonames data = Geonames.fromJson(response.data);
//       List<Geoname> filteredGeonames = data.geonames!
//           .where((geoname) =>
//               geoname.name != null &&
//               geoname.name!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       return filteredGeonames;
//     } else {
//       throw Exception('Failed to load city data');
//     }
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final cityService =
//       CityService('koruzed'); // Replace with your GeoNames API key

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('City Search'),
//         ),
//         body: CitySearchWidget(cityService),
//       ),
//     );
//   }
// }

// class CitySearchWidget extends StatefulWidget {
//   final CityService cityService;

//   CitySearchWidget(this.cityService);

//   @override
//   _CitySearchWidgetState createState() => _CitySearchWidgetState();
// }

// class _CitySearchWidgetState extends State<CitySearchWidget> {

//   final TextEditingController _searchController = TextEditingController();
//   List<Geoname> _searchcities = [];

//   void _searchCities(String query) async {
//     if (query.isNotEmpty) {
//       final cities = await widget.cityService.searchCities(query);
//       setState(() {
//         _searchcities = cities;
//       });
//     } else {
//       setState(() {
//         _searchcities = [];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           onSubmitted: _searchCities, // Use onChanged instead of onSubmitted
//           decoration: InputDecoration(labelText: 'Enter a city name'),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: _searchcities.length,
//             itemBuilder: (context, index) {
//               final city = _searchcities[index];
//               return ListTile(
//                 title: Text(city.name!),
//                 subtitle: Text(city.countryName!),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

