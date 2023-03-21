import 'package:flutter/material.dart';
class Declarations
{
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 201, 29, 126),
      Color.fromARGB(255, 221, 125, 187),
    ],
    stops: [0.5, 1.0],
  );
  static const appBarGradient2 = LinearGradient(
    colors: [
      Color.fromARGB(255, 221, 125, 187),
      Color.fromARGB(255, 201, 29, 126),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(109, 141, 53, 1.0);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffdcdcf3);
  static var selectedNavBarColor = const Color.fromARGB(255, 41, 59, 185);
  static const unselectedNavBarColor = Colors.blueGrey;

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    } else {
      return value;
    }
  }
}