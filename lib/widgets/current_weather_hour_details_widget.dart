import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import './single_info_row.dart';
import '../providers/weatherCModel.dart' as wcm;

class CurrentWeatherHourDetails extends StatefulWidget {
  final wcm.WeatherCModel hourInfo;

  CurrentWeatherHourDetails({this.hourInfo});

  @override
  _CurrentWeatherHourDetailsState createState() =>
      _CurrentWeatherHourDetailsState();
}

class _CurrentWeatherHourDetailsState extends State<CurrentWeatherHourDetails> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    translate(int time) {
      var translateT = DateTime.fromMillisecondsSinceEpoch(time * 1000);
      var translatetime = DateFormat("dd MMM, hh:mm a").format(translateT);
      return translatetime;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded ? min(12 * 20.0 + 107.0, 200) : 82,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
      child: Card(
        elevation: 0,
        color: Colors.blue[300],
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                "http://openweathermap.org/img/wn/${widget.hourInfo.icon}d@2x.png",
                fit: BoxFit.fitWidth,
              ),
              title: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  translate(widget.hourInfo.dt),
                  style: GoogleFonts.alata(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              subtitle: Text(
                "${widget.hourInfo.temp}°C | ${widget.hourInfo.weather}",
                style: GoogleFonts.alata(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isExpanded ? min(3 * 1.0 + 107.0, 200) : 0,
              decoration: BoxDecoration(
                  // color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleRowInfo(
                        texttype: "Pressure",
                        textans: "${widget.hourInfo.pressure} mbar"),
                    SingleRowInfo(
                        texttype: "Humidity",
                        textans: "${widget.hourInfo.humidity}%"),
                    SingleRowInfo(
                        texttype: "Visibiity",
                        textans:
                            "${((widget.hourInfo.visibility) / 1000).round()} km")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
