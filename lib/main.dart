import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/app/view/location_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dự báo thời tiết",
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: LocationView(),
    );
  }
}
