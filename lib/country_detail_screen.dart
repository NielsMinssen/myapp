import 'package:countries_world_map/data/maps/continents/africa.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'visited_countries_provider.dart';

class CountryDetailScreen extends StatefulWidget {
  final String countryName;
  final Function onVisitedChanged;

  CountryDetailScreen(
      {Key? key, required this.countryName, required this.onVisitedChanged})
      : super(key: key);

  @override
  _CountryDetailScreenState createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  late bool _visited;

  @override
  void initState() {
    super.initState();
    // Check if the country is already marked as visited
    _visited = Provider.of<VisitedCountriesProvider>(context, listen: false)
        .isCountryVisited(widget.countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter, // Aligns the child to the top-left of the container
            padding: const EdgeInsets.all(10), // Adds padding inside the container
            margin: const EdgeInsets.all(10), // Adds margin outside the container
            child: Text(
              'Have you visited ${widget.countryName}?',
              style: const TextStyle(fontSize: 30.0),
            ),
          ),
          Transform.scale(
            scale: 3,
          child: Checkbox(
            value: _visited,
            onChanged: (bool? value) {
              Provider.of<VisitedCountriesProvider>(context, listen: false)
                  .toggleCountryVisited(widget.countryName);
              setState(() {
                _visited = value!;
              });
              widget.onVisitedChanged(widget.countryName, _visited);
            },
          ),
          ),
        ],
      ),
    );
  }
}
