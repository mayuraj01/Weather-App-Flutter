import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  final String apiKey = 'Your API Key';

  Future<Weather> fetchWeather(String cityName) async{
    final url =Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(url);

    if(response.statusCode == 200){
      return Weather.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }
}
