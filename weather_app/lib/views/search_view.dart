import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:get/get.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  List<Geoname> _searchcities = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  void _searchCities(String query) async {
    if (query.isNotEmpty) {
      final cities = await _presenter.cityService.searchCities(query);
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
    return Container(
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
                  labelStyle: GoogleFonts.saira(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: 'location',
                  hintStyle: GoogleFonts.saira(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3)),
                      color: Colors.blue.shade400,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_searchController.text.isNotEmpty &&
                            _presenter.isConnect.value == true) {                          _searchCities(_searchController.text);
                        }
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
                    .withOpacity(0.5),
              ),
              child: _searchcities.length > 0 &&
                      _presenter.isConnect.value == true
                  ? ListView.builder(
                      shrinkWrap: true, // Add this line
                      itemCount: _searchcities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            if (_searchcities[index].name !=
                                _presenter.weatherData.value.address!.value) {
                              _presenter.isLoading.value = true;
                              _presenter.changeCity.value = true;

                              ///
                              _presenter.nowCity.value = true;
                              _presenter.newcity.value = _searchcities[index];
                            }
                            _presenter.scaffoldKey.value.currentState
                                ?.closeDrawer();
                          },
                          title: Text(
                            _searchcities[index].name!,
                            style: GoogleFonts.saira(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(_searchcities[index].countryName ?? '',
                                style: GoogleFonts.saira(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                              'assets/icons/${_presenter.isConnect.value == false ? 'no-internet.png' : 'map-location.gif'}'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'No ${_presenter.isConnect.value == false ? 'Internet' : 'Location'}..'
                                : '',
                            style: GoogleFonts.saira(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
