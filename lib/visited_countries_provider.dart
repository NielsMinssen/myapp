import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VisitedCountriesProvider with ChangeNotifier {
  final Set<String> _visitedCountries = {};

 int get visitedCount => _visitedCountries.length;
 bool isCountryVisited(String countryName) {
    return _visitedCountries.contains(countryName);
  }

  void toggleCountryVisited(String countryName) {
    if (_visitedCountries.contains(countryName)) {
      _visitedCountries.remove(countryName);
    } else {
      _visitedCountries.add(countryName);
    }
    notifyListeners();
  }
}
