import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VisitedCountriesProvider with ChangeNotifier {
  final Set<String> _visitedCountries = {};

 int get visitedCount => _visitedCountries.length;

 Set<String> get visitedCountries => _visitedCountries;

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

   void setVisitedCountries(Set<String> countries) {
    _visitedCountries
      ..clear()
      ..addAll(countries);
    notifyListeners();
  }
}
