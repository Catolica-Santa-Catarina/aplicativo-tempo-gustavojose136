import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tempo_template/services/locationService.dart';

import '../models/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocation() async {
   var locationService = LocationService();
    Location location = await locationService.getCurrentLocation();
  
    log("Latitude: ${location.latitude}, Longitude: ${location.longitude}");
  }

  Future<void> getWeatherData() async{
    var url = Uri.parse(
      'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');

    var response = await http.get(url);

    if(response.statusCode == 200){
      var data = response.body;
      log(data);
    }else{
      log(response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          child: const Text('Obter Localização'),
        ),
      ),
    );
  }
}
