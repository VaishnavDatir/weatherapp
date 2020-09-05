import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/current_weather_widgets.dart';
import '../widgets/current_weather_details_widget.dart';
import '../widgets/current_weather_hour_details_widget.dart';
import '../widgets/modal_sheet_single_row.dart';

import 'package:provider/provider.dart';
import '../providers/weatherCprovider.dart';

import 'package:google_fonts/google_fonts.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<WeatherCpro>(context, listen: false).fetchAndSetData(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            if (dataSnapShot.error != null) {
              //Do Error handling stuff
              return Center(
                  child: const Text(
                      "Error While Fetching Data\n Check Network Connection"));
            } else {
              return Consumer<WeatherCpro>(builder: (ctx, data, child) {
                return RefreshIndicator(
                  onRefresh: () {
                    return Provider.of<WeatherCpro>(context, listen: false)
                        .fetchAndSetData();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        elevation: 0,
                        expandedHeight: 140,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 30, left: 10, right: 10),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "The Weather App",
                                style: GoogleFonts.cabin(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          title: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                data.address,
                                style: GoogleFonts.lexendPeta(
                                    fontSize: 22, letterSpacing: -3),
                              ),
                            ),
                          ),
                          centerTitle: true,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white24
                              /* gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.3, 0.8],
                                colors: [Colors.blue, Colors.blue[900]]), */
                              ),
                          child: Column(
                            children: [
                              Container(
                                child: CurrnetWeatherWidgets(
                                  currentWeather: data.weathercp[0],
                                  max: data.dailyWeathercp[0].temp,
                                  min: data.dailyWeathercp[0].feelsLike,
                                ),
                              ),
                              CurrentWeatherDetailsWidget(
                                  currentDetails: data.weathercp[0]),
                              HourlyText(),
                              LimitedBox(
                                maxHeight: 350,

                                /* width: double.infinity,
                                height: 350, */
                                child: ListView.builder(
                                    itemCount: 8,
                                    itemBuilder: (ctx, index) =>
                                        CurrentWeatherHourDetails(
                                          hourInfo:
                                              data.hourlyWeathercp[index + 1],
                                        )),
                              ),
                              IconButton(
                                  iconSize: 36,
                                  color: Colors.blue,
                                  tooltip: "Next 7 Days",
                                  icon: Icon(Icons.keyboard_arrow_up),
                                  onPressed: () {
                                    _showModalBottomSheetDaily(
                                        context, data.dailyWeathercp);
                                  }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
            }
          }
        },
      ),
    );
  }
}

//THE MODAL SHEET
_showModalBottomSheetDaily(context, data) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 420,
          margin: EdgeInsets.only(left: 1, right: 1, top: 4),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ModalSheetWidget(
            dailyInfo: data,
          ),
        );
      });
}

//HOURLY TEXT
class HourlyText extends StatelessWidget {
  const HourlyText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: Column(
        children: [
          Text("Hourly",
              textAlign: TextAlign.center,
              style: GoogleFonts.alata(fontSize: 23)),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

// LOADING SCREEN
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 73,
          width: 73,
          child: CircularProgressIndicator(
            strokeWidth: 7,
            //backgroundColor: Colors.white,
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                "Getting Stats",
                style: GoogleFonts.alata(
                  fontSize: 24,
                  //color: Colors.white,
                  letterSpacing: 2.5,
                ),
              ),
            )),
      ],
    );
  }
}
