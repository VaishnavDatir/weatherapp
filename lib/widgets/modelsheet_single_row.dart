import 'package:flutter/material.dart';
import '../providers/weatherCModel.dart' as wcm;
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalSheetSingleRow extends StatelessWidget {
  final wcm.WeatherCModel dailyInfo;

  ModalSheetSingleRow({this.dailyInfo});

  translate(int time) {
    var translateT = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var translatetime = DateFormat("EEEE").format(translateT);
    return translatetime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
      child: ListTile(
        leading: Container(
          child: Image.network(
            "http://openweathermap.org/img/wn/${dailyInfo.icon}d@2x.png",
          ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            "${translate(dailyInfo.dt)}",
            softWrap: true,
            style: GoogleFonts.lexendPeta(
              fontSize: 19,
              letterSpacing: -1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
          "${dailyInfo.weather}",
          softWrap: true,
          style: GoogleFonts.lexendPeta(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        trailing: Text(
          "${dailyInfo.temp}°C | ${dailyInfo.feelsLike}°C",
          softWrap: true,
          style: GoogleFonts.lexendPeta(
            fontSize: 19,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
