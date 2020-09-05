import 'package:WeatherApp/providers/weatherCprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => WeatherCpro(),
      child: MaterialApp(
        title: 'The Weather Stats',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WeatherScreen(),
      ),
    );
  }
}
