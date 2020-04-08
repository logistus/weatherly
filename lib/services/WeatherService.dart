import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherly/models/CityDetail.dart';

class WeatherService {
  final String apiKey = "ada32cd0bb0c5fb253b34e80244572dd";

  Future<CityDetail> fetchCity(String city, String unit) async {

    final response = await http.get('http://api.weatherstack.com/current?query=${city}&access_key=${apiKey}&units=${unit}');
    if (response.statusCode == 200) {
      if (json.decode(response.body).containsKey("success")) {
        throw Exception(json.decode(response.body)["error"]["info"]);
      }
      return CityDetail.fromJSON(json.decode(response.body));
    } else {
      throw Exception("failed to load");
    }
  }


  Future<bool> checkCity(String city) async {
    final response = await http.get('http://api.weatherstack.com/current?access_key=' + apiKey + '&query=' + city);
    if(response.statusCode == 200) {
      // success = false şeklinde geri dönüş yapıyor şehir yoksa, bu anahtar yoksa şehir bulunmuş demek
      return !json.decode(response.body).containsKey("success");
    }
    return false;
  }
}