import 'package:flutter/material.dart';

class weather {
  final String CityName;
  final double temperature;
  final String condition;

  weather({
    required this.CityName,
    required this.temperature,
    required this.condition,
  });

  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
      CityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}
