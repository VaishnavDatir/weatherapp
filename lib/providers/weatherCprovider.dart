import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'weatherCModel.dart';
import 'dart:math';
import 'package:location/location.dart';

class WeatherCpro with ChangeNotifier {
  List<WeatherCModel> _weathercp = [];
  List<WeatherCModel> get weathercp {
    return [..._weathercp];
  }

  List<WeatherCModel> _hourlyWeathercp = [];
  List<WeatherCModel> get hourlyWeathercp {
    return [..._hourlyWeathercp];
  }

  List<WeatherCModel> _dailyWeathercp = [];
  List<WeatherCModel> get dailyWeathercp {
    return [..._dailyWeathercp];
  }

  String address;
  Future<void> fetchAndSetData() async {
    final loc = await Location().getLocation();
    final latitude = loc.latitude;
    final longitude = loc.longitude;

    try {
      final geourl =
          "http://dev.virtualearth.net/REST/v1/Locations/$latitude,$longitude?includeEntityTypes=Address&key=AlDdar_aLhwM242GlSWUvv_sWVV15RytiJUxfbygzB4cM1BEQGFTIBbimY5aijJ5";

      final geores = await http.get(geourl);
      final geojsonbody = json.decode(geores.body) as Map<String, dynamic>;
      final georesset = geojsonbody["resourceSets"] as List<dynamic>;

      List cst = [];
      georesset.forEach((element) => cst = element["resources"]);
      Map add;

      cst.forEach((element) {
        add = element["address"] as Map<String, dynamic>;
      });

      address = add["addressLine"];
    } catch (error) {
      print("ERROR IN LOCATION:");
      print(error);
    }

    try {
      final url =
          "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely&appid=2f8796eefe67558dc205b09dd336d022";

      final response = await http.get(url);
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;

      if (jsonBody == null) {
        print("JSON BODY is Empty");
        return;
      }
      print("JSON BODY SUCCESSFULLY FETCHED");

      final currentData = jsonBody["current"] as Map<String, dynamic>;
      List<WeatherCModel> currentDataDummy = [];
      currentDataDummy.add(WeatherCModel(
        dt: currentData["dt"],
        sunrise: currentData["sunrise"],
        sunset: currentData["sunset"],
        temp: ((currentData["temp"] - 273.15).round()).toString(),
        feelsLike: ((currentData["feels_like"] - 273.15).round()).toString(),
        pressure: currentData["pressure"],
        humidity: currentData["humidity"],
        uvi: currentData["uvi"],
        visibility: currentData["visibility"],
        weather: ((currentData["weather"] as List<dynamic>)
            .map((e) => e["main"])
            .first),
        icon: ((currentData["weather"] as List<dynamic>)
            .map((e) => e["icon"])
            .first
            .toString()
            .substring(0, 2)),
      ));
      _weathercp = currentDataDummy;
      print("Current Data fetched");

      final hourlyData = jsonBody["hourly"] as List<dynamic>;
      List<WeatherCModel> hourlyDataDummy = [];

      for (var i = 0; i < 9; i++) {
        final ele = hourlyData.elementAt(i);
        hourlyDataDummy.add(WeatherCModel(
          dt: ele["dt"],
          temp: ((ele["temp"] - 273.15).round()).toString(),
          pressure: ele["pressure"],
          humidity: ele["humidity"],
          visibility: ele["visibility"],
          weather: ((ele["weather"] as List<dynamic>)
              .map((e) => e["main"])
              .first
              .toString()),
          icon: ((ele["weather"] as List<dynamic>)
              .map((e) => e["icon"])
              .first
              .toString()
              .substring(0, 2)),
        ));
      }
      /* hourlyData.forEach((element) {
        hourlyDataDummy.add(WeatherCModel(
          dt: element["dt"],
          temp: ((element["temp"] - 273.15).round()).toString(),
          pressure: element["pressure"],
          humidity: element["humidity"],
          visibility: element["visibility"],
          weather: ((element["weather"] as List<dynamic>)
              .map((e) => e["main"])
              .first
              .toString()),
          icon: ((element["weather"] as List<dynamic>)
              .map((e) => e["icon"])
              .first
              .toString()
              .substring(0, 2)),
        ));
      }); */
      print(hourlyDataDummy.length);
      _hourlyWeathercp = hourlyDataDummy;
      print("Hourly Data fetched");

      final dailyData = jsonBody["daily"] as List<dynamic>;
      List<WeatherCModel> dailyDataDummy = [];

      dailyData.forEach((element) {
        dailyDataDummy.add(WeatherCModel(
          dt: element["dt"],
          temp: ((element["temp"]["max"] - 273.15).round())
              .toString(), //TO SAVE MAX TEMP
          feelsLike: ((element["temp"]["min"] - 273.15).round())
              .toString(), //TO SAVE MIN TEMP
          weather: ((element["weather"] as List<dynamic>)
              .map((e) => e["main"])
              .first
              .toString()),
          icon: ((element["weather"] as List<dynamic>)
              .map((e) => e["icon"])
              .first
              .toString()
              .substring(0, 2)),
        ));
      });
      print(dailyData.length);
      _dailyWeathercp = dailyDataDummy;
      print("Daily Data fetched");

      notifyListeners();
      print("Data Successfully Fetched");
    } catch (ereoe) {
      print("THE EROOR in hourlay data IS:");
      print(ereoe);
    }
  }
}
