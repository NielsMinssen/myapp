import 'dart:math';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'country_detail_screen.dart';
import 'visited_countries_provider.dart';


class WorldMapGenerator extends StatefulWidget {
  WorldMapGenerator({Key? key}) : super(key: key);

  @override
  _WorldMapGeneratorState createState() => _WorldMapGeneratorState();
}

class _WorldMapGeneratorState extends State<WorldMapGenerator> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var visitedCountriesProvider = Provider.of<VisitedCountriesProvider>(context);
  Set<String> visitedCountries = visitedCountriesProvider.visitedCountries;

  // Build a map where keys are the country codes and values are Colors.yellow
  Map<String, Color> visitedCountryColors = {
    for (var countryCode in visitedCountries) countryCode: Color.fromARGB(255, 245, 196, 71),
  };
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          InteractiveViewer(
            maxScale: 75.0,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    // Actual widget from the Countries_world_map package.
                    child: SimpleMap(
                      countryBorder: CountryBorder(color: Colors.white),
                      instructions: SMapWorld.instructionsMercator,
                      callback: (id, name, tapDetails) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CountryDetailScreen(
                            countryName: id,
                            onVisitedChanged:
                                (String countryName, bool visited) {
                              // Handle the state change for visited countries
                            },
                          ),
                        ));
                      },
                     defaultColor: Colors.black,
                     colors: visitedCountryColors,
                        
                    ),
                  ),
                  // Creates 8% from right side so the map looks more centered.
                  Container(width: MediaQuery.of(context).size.width * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
