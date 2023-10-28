import 'package:cimilo_sheeg/model/weathermodel.dart';
import 'package:cimilo_sheeg/weatherapi/weatherservice.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class weatherpage extends StatefulWidget {
  const weatherpage({super.key});

  @override
  State<weatherpage> createState() => _weatherpageState();
}

class _weatherpageState extends State<weatherpage> {
  final _weatherservice = weathersevice('2398f1ebdfdb3799c7c9076b04ca1a1a');

  weather? _weather;

  //fetch the weather
  _fetchweather() async {
    String CityName = await _weatherservice.getcurrentCity();

    try {
      final weather = await _weatherservice.getweather(CityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather
  String getweaatherAnimation(String? condition) {
    if (condition == null) return "lib/images/iftiin.json";
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/images/rooble.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/images/rooble.json';
      case 'clear':
        return 'lib/images/Qorax.json';
      case 'thunderstorm':
        return 'lib/images/Q&r.json';
      default:
        return "lib/images/iftiin.json";
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // bilowga ayuu fetch gareyna
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.CityName ?? "Loading city.."),
            // animation
            Lottie.asset(getweaatherAnimation(_weather?.condition)),
            // temperature
            Text('${_weather?.temperature.round()}°C'),

            // codintion
            Text(_weather?.condition ?? "")
          ],
        ),
      ),
    );
  }
}
