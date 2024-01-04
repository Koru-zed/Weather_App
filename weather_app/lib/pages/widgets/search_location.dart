import 'package:flutter/material.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final dio = Dio();

class CityService {
  final String apiKey;
  final String apiUrl = 'http://api.geonames.org/searchJSON';

  CityService(this.apiKey);

  Future<List<Geoname>> searchCities(String query) async {
    print('$apiUrl?q=$query&maxRows=20&username=$apiKey');

    final response =
        await dio.get('$apiUrl?q=$query&maxRows=20&username=$apiKey');

    if (response.statusCode == 200) {
      Geonames data = Geonames.fromJson(response.data);
      List<Geoname> filteredGeonames = data.geonames!
          .where((geoname) =>
              geoname.name != null &&
              geoname.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredGeonames.forEach((element) {
        print('=> ${element.name}');
      });

      return filteredGeonames;
    } else {
      throw Exception('Failed to load city data');
    }
  }
}

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}
class _SearchLocationState extends State<SearchLocation> {
  final cityService = CityService('koruzed');
  final TextEditingController _searchController = TextEditingController();
  List<Geoname> _searchcities = [];
  GlobalController _controller = Get.put(GlobalController());

  void _searchCities(String query) async {
    if (query.isNotEmpty) {
      final cities = await cityService.searchCities(query);
      setState(() {
        _searchcities = cities;
      });
    } else {
      setState(() {
        _searchcities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              height: 37,
              child: TextField(
                controller: _searchController,
                onSubmitted: _searchCities,
                decoration: InputDecoration(
                  contentPadding: const
                      EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  border: const OutlineInputBorder(),
                  labelText: 'location',
                  labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400,),
                  hintText: 'location',
                  hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  suffixIcon: Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                    child: const Icon(
                      Icons.search_sharp,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)),
                  color: Theme.of(context).drawerTheme.backgroundColor!.withOpacity(0.8),
                ),
                child: ListView.builder(
                  shrinkWrap: true, // Add this line
                  itemCount: _searchcities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print('popopopopppo');
                        if (_searchcities[index].name !=
                            _controller.city.value) {
                          _controller.isLoading.value = true;
                          _controller.newcity.value = _searchcities[index];
                          print('eeeeeeeeeeeeeee');
                        }
                        _controller.scaffoldKey.value.currentState?.closeDrawer();
                      },
                      title: Text(_searchcities[index].name!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10,),
                        child: Text(_searchcities[index].countryName!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
