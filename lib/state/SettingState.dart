import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingState with ChangeNotifier {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<String> _temperature_unit = _prefs.then((SharedPreferences prefs) {
    return (prefs.getString('temperature_unit') ?? 'm');
  });

  Future<String> get temperature_unit => _temperature_unit;

  void updateTemperatureUnit() {
    _temperature_unit = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('temperature_unit') ?? 'm');
    });
  }

  void changeTemperatureUnit(String newUnit) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('temperature_unit', newUnit);
    });
    updateTemperatureUnit();
    notifyListeners();
  }

}