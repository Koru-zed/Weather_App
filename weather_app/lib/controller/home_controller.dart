part of './controller_library.dart';




// // import 'package:dio/dio.dart';
// // import 'package:intl/intl.dart';
// // import 'dart:convert';
// // // Import the intl package for date formatting

// // Future<void> fetchWeatherData(String cityName, String apiKey) async {
// //   final dio = Dio();
// //   final baseUrl =
// //       'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';

// //   final currentDateTime = DateTime.now();
// //   final startDate = currentDateTime.subtract(Duration(days: 3));
// //   final endDate = currentDateTime.add(Duration(days: 5));

// //   final dateFormat = DateFormat("yyyy-M-d'T'H:m:s");
// //   final formattedStartDate = dateFormat.format(startDate);
// //   final formattedEndDate = dateFormat.format(endDate);

// //   final url =
// //       '$baseUrl$cityName/$formattedStartDate/$formattedEndDate?key=$apiKey&unitGroup=us&include=obs';
// //   print('url $url');

// //   try {
// //     final response = await dio.get(url);

// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> data = json.decode(response.data.toString());

// //       // Process and use the data as needed
// //       // Example: Print hourly data for the last 3 days and the next 5 days
// //       final List<dynamic> hourlyData = data['days'][0]['hours'];
// //       for (final hourData in hourlyData) {
// //         final DateTime dateTime = DateTime.parse(hourData['datetime']);
// //         final double temperature = hourData['temp2m'];
// //         // print('DateTime: $dateTime, Temperature: $temperature');
// //       }
// //     } else {
// //       // Handle errors
// //       print('Error: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     // Handle exceptions
// //     print('Exception: $e');
// //   }
// // }

// // void main() {
// //   // Replace 'your_city_name' and 'your_api_key' with the actual city name and your Visual Crossing API key
// //   fetchWeatherData('tokyo', 'FC58M2QNG3YQD65J65A8FSXYZ');
// // }

// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

// Future<void> fetchWeatherData(String cityName, String apiKey) async {
//   final dio = Dio();
//   final baseUrl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';

//   final currentDateTime = DateTime.now();
//   final startDate = currentDateTime.subtract(Duration(days: 3));
//   final endDate = currentDateTime.add(Duration(days: 5));

//   final dateFormat = DateFormat("yyyy-M-d'T'H:m:s");
//   final formattedStartDate = dateFormat.format(startDate);
//   final formattedEndDate = dateFormat.format(endDate);

//   final url = '$baseUrl$cityName/$formattedStartDate/$formattedEndDate?key=$apiKey&unitGroup=us&include=obs';

//   try {
//     final response = await dio.get(url);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.data.toString());

//       // Process and use the data as needed
//       // Example: Print hourly data for the current day and the next 5 days
//       final List<dynamic> hourlyDataCurrentDay = data['days'][0]['hours'];
//       for (final hourData in hourlyDataCurrentDay) {
//         final DateTime dateTime = DateTime.parse(hourData['datetime']);
//         final double temperature = hourData['temp2m'];
//         final double clouds = hourData['cloudcover'];
//         final double humidity = hourData['humidity'];
//         final double windSpeed = hourData['windspeed'];

//         print('DateTime: $dateTime, Temperature: $temperature, Clouds: $clouds, Humidity: $humidity, Wind Speed: $windSpeed');
//       }

//       // Example: Print hourly data for the next 5 days
//       for (int i = 1; i < data['days'].length; i++) {
//         final List<dynamic> hourlyData = data['days'][i]['hours'];
//         for (final hourData in hourlyData) {
//           final DateTime dateTime = DateTime.parse(hourData['datetime']);
//           final double temperature = hourData['temp2m'];
//           final double clouds = hourData['cloudcover'];
//           final double humidity = hourData['humidity'];
//           final double windSpeed = hourData['windspeed'];

//           print('DateTime: $dateTime, Temperature: $temperature, Clouds: $clouds, Humidity: $humidity, Wind Speed: $windSpeed');
//         }
//       }
//     } else {
//       // Handle errors
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle exceptions
//     print('Exception: $e');
//   }
// }


// void main() {
//   // Replace 'your_city_name' and 'your_api_key' with the actual city name and your Visual Crossing API key
//   fetchWeatherData('tokyo', 'FC58M2QNG3YQD65J65A8FSXYZ');
// }


