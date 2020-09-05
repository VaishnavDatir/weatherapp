import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/weatherCModel.dart' as wcm;
import 'package:intl/intl.dart';

class CurrnetWeatherWidgets extends StatelessWidget {
  final wcm.WeatherCModel currentWeather;
  final String max;
  final String min;
  CurrnetWeatherWidgets({this.currentWeather, this.max, this.min});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      // height: MediaQuery.of(context).size.width - 130,
      child: Column(
        children: <Widget>[
          Text(
            "${DateFormat.MMMMEEEEd().format(DateTime.now())}",
            style: GoogleFonts.alata(
              fontSize: 20,
              //color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 105,
                height: 105,
                child: Image.network(
                  "http://openweathermap.org/img/wn/${10}d@2x.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                currentWeather.temp,
                style: GoogleFonts.alata(
                  fontSize: 75,
                  //color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "°C",
                  style: GoogleFonts.alata(
                    fontSize: 40,
                    // color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 55,
              )
            ],
          ),
          Text(
            currentWeather.weather,
            style: GoogleFonts.alata(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                //color: Colors.white,
                letterSpacing: 2.5),
          ),
          Text(
            "Feels like ${currentWeather.feelsLike}°C",
            style: GoogleFonts.lexendPeta(
              fontSize: 18,
              // color: Colors.white,
              letterSpacing: -1.5,
            ),
          ),
          Text(
            "MAX $max°C | MIN $min°C",
            style: GoogleFonts.lexendPeta(
              fontSize: 16,
              letterSpacing: -2,
            ),
          )
        ],
      ),
    );
  }
}
