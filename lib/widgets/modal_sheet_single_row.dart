import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/modelsheet_single_row.dart';

class ModalSheetWidget extends StatelessWidget {
  final List dailyInfo;

  ModalSheetWidget({this.dailyInfo});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Text(
          "Next 7 Days",
          style: GoogleFonts.poppins(
            fontSize: 23, /* color: Colors.blue */
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          height: 330,
          child: ListView.builder(
            itemCount: 7,
            primary: true,
            itemBuilder: (ctx, index) => ModalSheetSingleRow(
              dailyInfo: dailyInfo[index + 1],
            ),
          ),
        )
      ],
    );
  }
}
