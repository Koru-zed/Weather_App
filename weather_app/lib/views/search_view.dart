import 'package:flutter/material.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:get/get.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  List<Geoname> _searchcities = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalController _controller = Get.put(GlobalController());

  void _searchCities(String query) async {
    if (query.isNotEmpty) {
      final cities = await _controller.cityService.searchCities(query);
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
            SizedBox(
              height: 37,
              child: TextField(
                controller: _searchController,
                onSubmitted: _searchCities,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    border: const OutlineInputBorder(),
                    labelText: 'location',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: 'location',
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (_searchController.text.isNotEmpty)
                            _searchCities(_searchController.text);
                        },
                        icon: const Icon(
                          Icons.search_sharp,
                          size: 20,
                        ),
                      ),
                    )),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(10)),
                  color: Theme.of(context)
                      .drawerTheme
                      .backgroundColor!
                      .withOpacity(0.8),
                ),
                child: ListView.builder(
                  shrinkWrap: true, // Add this line
                  itemCount: _searchcities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (_searchcities[index].name !=
                            _controller.city.value) {
                          _controller.isLoading.value = true;
                          _controller.newcity.value = _searchcities[index];
                        }
                        _controller.scaffoldKey.value.currentState
                            ?.closeDrawer();
                      },
                      title: Text(
                        _searchcities[index].name!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(_searchcities[index].countryName ?? '',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
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
