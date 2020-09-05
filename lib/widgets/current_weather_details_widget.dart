import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/single_info_row.dart';
import '../providers/weatherCModel.dart' as wcm;

class CurrentWeatherDetailsWidget extends StatelessWidget {
  final wcm.WeatherCModel currentDetails;

  CurrentWeatherDetailsWidget({this.currentDetails});

  @override
  Widget build(BuildContext context) {
    translate(int time) {
      var translateT = DateTime.fromMillisecondsSinceEpoch(time * 1000);
      var translatetime = DateFormat("hh:mm a").format(translateT);
      return translatetime;
    }

    kmtom(int vis) {
      var kmTom = vis / 1000;
      return kmTom.round();
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[300], borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Column(
        children: [
          SingleRowInfo(
              texttype: "Sunrise", textans: translate(currentDetails.sunrise)),
          Divider(color: Colors.white),
          SingleRowInfo(
              texttype: "Sunset", textans: translate(currentDetails.sunset)),
          Divider(color: Colors.white),
          SingleRowInfo(
              texttype: "Humidity", textans: "${currentDetails.humidity}%"),
          Divider(color: Colors.white),
          SingleRowInfo(texttype: "UV Index", textans: "${currentDetails.uvi}"),
          Divider(color: Colors.white),
          SingleRowInfo(
              texttype: "Pressure", textans: "${currentDetails.pressure} mbar"),
          Divider(color: Colors.white),
          SingleRowInfo(
              texttype: "Visibility",
              textans: kmtom(currentDetails.visibility).toString() + " km"),
        ],
      ),
    );
  }
}
