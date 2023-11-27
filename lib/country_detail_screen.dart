import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'visited_countries_provider.dart';

class CountryDetailScreen extends StatefulWidget {
  final String countryName;
  final Function onVisitedChanged;

  CountryDetailScreen({Key? key, required this.countryName, required this.onVisitedChanged}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Have you visited ${widget.countryName}?'),
          Checkbox(
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
        ],
      ),
    );
  }
}
