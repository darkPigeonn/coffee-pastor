import 'package:flutter/material.dart';

String url = "https://api.imavi.org/";
int apiWaitTime = 10;
Map<String, String> apiImavi= {
  "Id": "6147f10d33abc530a445fe84",
  "Secret": "88022467-0b5c-4e61-8933-000cd884aaa8",
  "Partner": "imavi",
};
late var fcmToken;

DateTime today = DateTime.now();

//color
liturgiColor(data) {
  var colorCall = data.toString().toLowerCase();
  var colorReturn = Color.fromARGB(255, 255, 255, 255); //cWhite
  // return colorReturn;
  if (colorCall == 'ungu') return Colors.purple;
  if (colorCall == 'hijau') return Colors.green[900];
  if (colorCall == 'merah') return Color.fromARGB(255, 192, 6, 6); //cPrimary
  if (colorCall == 'putih') return Color.fromARGB(255, 255, 255, 255); //cWhite
}

//theme liturgi
liturgiTheme(data) {
  var themeReturn = TextStyle();

  var colorCall = data.toString().toLowerCase();
  var colorReturn = Color.fromARGB(255, 255, 255, 255); //cWhite

  if (colorCall == 'ungu')
    return TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), //cWhite,
      fontSize: 16,
    );
  if (colorCall == 'hijau')
    return TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), //cWhite,,
      fontSize: 16,
    );
  if (colorCall == 'merah')
    return TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), //cWhite,,
      fontSize: 16,
    );
  if (colorCall == 'putih')
    return TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
}