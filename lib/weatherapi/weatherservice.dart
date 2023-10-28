import 'dart:convert';

import 'package:cimilo_sheeg/model/weathermodel.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class weathersevice {
  static const base_url = 'https://api.openweathermap.org/data/2.5/weather';

  final String apikey;

  weathersevice(this.apikey);

  Future<weather> getweather(String CityName) async {
    final response = await http
        .get(Uri.parse('$base_url?q=$CityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200) {
      return weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed');
    }
  }

  Future<String> getcurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //Fetch current user

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // covert location ito list
    List<Placemark> p =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? City = p[0].locality;

    return City ?? "";
  }
}
