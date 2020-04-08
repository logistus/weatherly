import 'package:flutter/cupertino.dart';
import 'package:weatherly/models/City.dart';
import '../DB.dart';

class CityState with ChangeNotifier {
  Future<List<City>> _cities = DB().listCities() ?? [];

  Future<List<City>> get cities => _cities;

  void _refreshCities() {
    _cities = DB().listCities();
  }

  void add(City city) {
    DB().insertCity(city);
    _refreshCities();
    notifyListeners();
  }

  void delete(int id) {
    DB().deleteCity(id);
    _refreshCities();
    notifyListeners();
  }

  void deleteAll() {
    DB().deleteAll();
    _refreshCities();
    notifyListeners();
  }
}