import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleRowInfo extends StatefulWidget {
  final String texttype;
  final String textans;

  SingleRowInfo({
    @required this.texttype,
    @required this.textans,
  });

  @override
  _SingleRowInfoState createState() => _SingleRowInfoState();
}

class _SingleRowInfoState extends State<SingleRowInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.texttype,
          style: GoogleFonts.alata(fontSize: 23, color: Colors.white),
        ),
        Text(
          widget.textans,
          style: GoogleFonts.alata(
              fontSize: 23, color: Colors.white, letterSpacing: -0.6),
        ),
      ],
    );
  }
}
