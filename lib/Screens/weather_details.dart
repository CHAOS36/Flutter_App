import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDetails extends StatefulWidget {
  final String city;

  WeatherDetails({required this.city});

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  var weatherData;

  @override
  void initState() {
    super.initState();
    getWeatherData(widget.city);
  }

  Future<void> getWeatherData(String city) async {
    final String apiKey = '9299a440a78f4733968d774fba84f5b7'; // Remplacez par votre clé API
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Erreur lors du chargement des données météo');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather in ${widget.city}')),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature: ${weatherData['main']['temp']}°C',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Description: ${weatherData['weather'][0]['description']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Humidity: ${weatherData['main']['humidity']}%',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
