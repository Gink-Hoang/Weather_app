import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weather_app/app/controller/weather_controller.dart';
import 'package:weather_app/app/model/weather_model.dart';
import 'package:weather_app/app/util/weather_status.dart';

import '../util/constrants.dart';

class LocationView extends StatelessWidget {
  final controller = Get.put(WeatherController());
  final status = Get.put(WeatherStatus());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
        future: controller.getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("$snapshot.error.toString()"),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            var icon = WeatherStatus().getWeatherIcon(data!.cod);

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/location_background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            controller.getWeatherData();
                          },
                          child: const Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${data.main.temp.toInt().toString()}°",
                            style: kTempTextStyle,
                          ),
                          Text(
                            WeatherStatus().getWeatherIcon(data.cod),
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "${WeatherStatus().getMessage(data.main.temp.toInt())} in ${data.name}!",
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: SpinKitDoubleBounce(color: Colors.blue, size: 50),
          );
        },
      ),
    );
  }
}
